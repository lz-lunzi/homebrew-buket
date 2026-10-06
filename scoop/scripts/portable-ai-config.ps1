<#
.SYNOPSIS
    Portable AI CLI config via NTFS junctions into the Scoop root.

.DESCRIPTION
    Scoop lives on a synced drive, so software survives OS reinstall / user switch.
    This script makes AI CLI config live there too, WITHOUT any registry state
    (no user/system env vars -- those die with the user or the OS).

    Mechanism: NTFS junctions from the home dir into <scoop>\config\<tool>.
    A junction is re-created per user by re-running this script, and the same
    logic can be inlined into bucket manifests' post_install (see omp.json for
    the reference implementation), so `scoop install <app>` itself rebuilds it.

        ~/.codex            -> <scoop>\config\codex    (junction, no privilege needed)
        ~/.claude           -> <scoop>\config\claude   (junction)
        ~/.claude.json      -> <scoop>\config\claude\.claude.json (file symlink;
                               falls back to a real copy if symlink is not permitted)
        ~/.codem            -> <scoop>\config\codem    (junction; skipped while codem runs)

    Non-destructive: the old real dir is renamed to <dir>.local-backup, never
    deleted. Delete backups manually once the junction is verified.
    Idempotent: re-run any time; already-migrated tools are skipped.

.EXAMPLE
    # bootstrap on a new user account / new OS (after scoop + this bucket are set up):
    powershell -File scoop/scripts/portable-ai-config.ps1

    # include codem (close all codem sessions first):
    powershell -File scoop/scripts/portable-ai-config.ps1 -Codem
#>
[CmdletBinding()]
param(
    [switch]$Codem
)

$ErrorActionPreference = 'Continue'

# ---------- 1. Locate Scoop root ----------
$scoopCmd = Get-Command scoop -ErrorAction SilentlyContinue
$scoopRoot = if ($env:SCOOP) { $env:SCOOP }
             elseif ($scoopCmd) { Split-Path (Split-Path $scoopCmd.Source) }
             else { throw 'scoop not found; run from a shell where scoop is initialized' }
$configRoot = Join-Path $scoopRoot 'config'
New-Item -ItemType Directory -Force -Path $configRoot | Out-Null
Write-Host "Scoop root : $scoopRoot"
Write-Host "Config root: $configRoot"
Write-Host ''

function Move-ToJunction {
    param([string]$HomeDir, [string]$Target, [string]$Label)

    New-Item -ItemType Directory -Force -Path $Target | Out-Null

    if (Test-Path $HomeDir) {
        $item = Get-Item $HomeDir -ErrorAction SilentlyContinue
        if ($item -and $item.LinkType) {
            if ($item.Target -eq $Target) {
                Write-Host "[$Label] already $($item.LinkType) -> $Target" -ForegroundColor Green
            } else {
                Write-Warning "[$Label] is a $($item.LinkType) but points to $($item.Target) (expected $Target); left untouched"
            }
            return
        }
        # catch-up incremental copy of the real dir
        robocopy $HomeDir $Target /E /XJ /R:1 /W:1 /NFL /NDL /NP | Out-Null
        if ($LASTEXITCODE -ge 8) {
            Write-Warning "[$Label] robocopy failed (exit $LASTEXITCODE); skipped"
            return
        }
        $backup = "$HomeDir.local-backup"
        if (Test-Path $backup) {
            Write-Warning "[$Label] backup already exists: $backup; move it away and re-run"
            return
        }
        try { Rename-Item $HomeDir $backup -ErrorAction Stop }
        catch {
            Write-Warning "[$Label] cannot rename $HomeDir (some app holds it open -- close VS Code/editors/terminals with that folder open, then re-run)"
            return
        }
        New-Item -ItemType Junction -Path $HomeDir -Target $Target | Out-Null
        Write-Host "[$Label] junction $HomeDir -> $Target (old dir kept at $backup)" -ForegroundColor Green
    } else {
        # fresh user/OS: home dir absent, create the junction directly
        New-Item -ItemType Junction -Path $HomeDir -Target $Target | Out-Null
        Write-Host "[$Label] junction $HomeDir -> $Target (fresh)" -ForegroundColor Green
    }
}

# ---------- 2. codex ----------
Move-ToJunction -HomeDir "$HOME\.codex" -Target (Join-Path $configRoot 'codex') -Label 'codex'

# ---------- 3. claude ----------
Move-ToJunction -HomeDir "$HOME\.claude" -Target (Join-Path $configRoot 'claude') -Label 'claude'

$claudeJson = "$HOME\.claude.json"
$targetJson = Join-Path $configRoot 'claude\.claude.json'
if (Test-Path $claudeJson) {
    $cj = Get-Item $claudeJson
    if (-not $cj.LinkType) {
        # always sync current content to the target first, so nothing is lost below
        Copy-Item $claudeJson $targetJson -Force
        $jsonBackup = "$claudeJson.local-backup"
        if (Test-Path $jsonBackup) {
            Write-Warning "[claude] .claude.json: kept real file (backup $jsonBackup already exists; content already synced to target)"
        } else {
            try {
                Rename-Item $claudeJson $jsonBackup -ErrorAction Stop
                New-Item -ItemType SymbolicLink -Path $claudeJson -Target $targetJson -ErrorAction Stop | Out-Null
                Write-Host "[claude] .claude.json symlink -> $targetJson" -ForegroundColor Green
            } catch {
                if (-not (Test-Path $claudeJson)) { Copy-Item $targetJson $claudeJson }
                Write-Warning "[claude] symlink not permitted; kept a real copy of .claude.json (content synced to target)"
            }
        }
    } elseif ($cj.Target -ne $targetJson) {
        Write-Warning "[claude] .claude.json links to $($cj.Target) (expected $targetJson); left untouched"
    } else {
        Write-Host "[claude] .claude.json already -> $targetJson" -ForegroundColor Green
    }
} elseif (-not (Test-Path "$claudeJson.local-backup")) {
    # fresh user: symlink if possible, otherwise copy
    if (Test-Path $targetJson) {
        try { New-Item -ItemType SymbolicLink -Path $claudeJson -Target $targetJson -ErrorAction Stop | Out-Null }
        catch { Copy-Item $targetJson $claudeJson }
        Write-Host "[claude] .claude.json staged on fresh profile" -ForegroundColor Green
    }
}

# ---------- 4. codem (junction only when no codem process is alive) ----------
if ($Codem) {
    $running = Get-Process codem -ErrorAction SilentlyContinue
    if ($running) {
        Write-Warning "[codem] codem is running (PID: $($running.Id -join ', ')); close all codem sessions and re-run"
    } else {
        Move-ToJunction -HomeDir "$HOME\.codem" -Target (Join-Path $configRoot 'codem') -Label 'codem'
    }
} else {
    Write-Host '[codem] skipped (pass -Codem after closing all codem sessions)'
}

Write-Host ''
Write-Host 'Done.' -ForegroundColor Cyan
Write-Host '  New user / new OS bootstrap: install scoop -> add this bucket -> run this script.'
Write-Host '  Delete *.local-backup leftovers after verifying everything works.'
