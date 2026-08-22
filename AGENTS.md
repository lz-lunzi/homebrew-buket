# AGENTS.md

Homebrew tap + Scoop bucket 合并仓库。

## 平台策略

- **Windows**: Scoop (`bucket/*.json`)
- **macOS (Apple Silicon)**: Homebrew (`Formula/*.rb`, `Casks/*.rb`)
- **Linux**: Homebrew (`Formula/*.rb`)

Mac 全部 M 系列芯片，formula 只需 arm64 架构。

## 结构

```
Formula/              Homebrew formula (.rb)
Casks/                Homebrew cask (.rb)
bucket/               Scoop manifests (.json)

homebrew/scripts/     Homebrew 辅助脚本 (.rb)
scoop/scripts/        Scoop 辅助脚本 (.ps1)

.github/workflows/
├── homebrew/         Homebrew CI
│   ├── auto-retire.yml    检测官方重复包，自动 deprecate/disable
│   └── auto-update.yml    bump formulae + casks 版本
└── scoop/            Scoop CI
    ├── ci.yml             manifest 格式测试
    └── excavator.yml      4 小时自动更新 checkver/autoupdate
```

## 使用

**Windows (Scoop):**
```powershell
scoop bucket add mybucket https://github.com/user/homebrew-buket
scoop install mybucket/<app>
```

**macOS / Linux (Homebrew):**
```bash
brew tap user/homebrew-buket
brew install <formula>
brew install --cask <cask>
```

## 路径约定

- Scoop workflow 引用 `scoop/scripts/*.ps1`
- Scoop ps1 脚本用 `$PSScriptRoot/../../bucket` 找 manifests
- Homebrew workflow 引用 `homebrew/scripts/*.rb`（相对 repo root）

## 添加包

**Windows 软件:** `bucket/<name>.json` (Scoop manifest)
**macOS/Linux 软件:** `Formula/<name>.rb` (Homebrew formula)
**macOS GUI 应用:** `Casks/<name>.rb` (Homebrew cask)

同一软件跨平台：两边都加，文件名可不同（Homebrew 用 snake_case，Scoop 用 kebab-case）。
