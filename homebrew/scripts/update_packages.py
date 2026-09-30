#!/usr/bin/env python3
"""Scan all Formula/*.rb and bucket/*.json, detect package sources,
fetch latest versions + checksums, and update version + sha256/hash.

Priority: npm registry > GitHub releases.
GitHub only used when file has /releases/download/ URLs.

Dry-run by default. Use --apply to write files.
"""
from __future__ import annotations

import argparse
import hashlib
import json
import os
import re
import sys
import time
import urllib.error
import urllib.parse
import urllib.request
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
FORMULA = ROOT / "Formula"
BUCKET = ROOT / "bucket"


def get(url: str, timeout: int = 30, retries: int = 3) -> bytes:
    headers = {"User-Agent": "homebrew-buket-update"}
    token = os.getenv("GITHUB_TOKEN")
    if token and "github.com" in url:
        headers["Authorization"] = f"Bearer {token}"
    last_error = None
    for attempt in range(retries):
        try:
            request = urllib.request.Request(url, headers=headers)
            with urllib.request.urlopen(request, timeout=timeout) as response:
                return response.read()
        except (urllib.error.URLError, TimeoutError) as error:
            last_error = error
            if attempt < retries - 1:
                time.sleep(2 * (attempt + 1))
    raise last_error


def github_release(repo: str) -> tuple[str, dict[str, str]]:
    data = json.loads(get(f"https://api.github.com/repos/{repo}/releases/latest"))
    version = data["tag_name"].removeprefix("v")
    asset_list = data["assets"]
    assets = {a["name"]: a["browser_download_url"] for a in asset_list}
    checksums: dict[str, str] = {}
    checksum_url = next(
        (url for name, url in assets.items() if "sha256" in name.lower() or "checksum" in name.lower()),
        None,
    )
    if checksum_url:
        try:
            for line in get(checksum_url, timeout=90).decode().splitlines():
                match = re.match(r"^([0-9a-fA-F]{64})\s+[* ]?(.+)$", line.strip())
                if match:
                    checksums[Path(match.group(2)).name] = match.group(1).lower()
        except (urllib.error.URLError, TimeoutError):
            pass
    for a in asset_list:
        digest = a.get("digest")
        if digest and digest.startswith("sha256:"):
            checksums[a["name"]] = digest.removeprefix("sha256:")
    return version, {name: checksums[name] for name in assets if name in checksums}


def sha256_hex(url: str, timeout: int = 300) -> str:
    return hashlib.sha256(get(url, timeout=timeout)).hexdigest()


def npm_latest(package: str) -> tuple[str, str, str]:
    encoded = urllib.parse.quote(package, safe="@/")
    data = json.loads(get(f"https://registry.npmjs.org/{encoded}/latest"))
    return data["version"], data["dist"]["tarball"], data.get("name", package)


def detect_github_repo(text: str) -> str | None:
    if "/releases/download/" not in text:
        return None
    match = re.search(r"github\.com/([^/\s\"']+/[^/\s\"']+?)(?:[\"'/]|\.(?:rb|json))", text)
    if match:
        repo = match.group(1).removesuffix(".git")
        if "/" in repo and not repo.endswith("/"):
            return repo
    match = re.search(r"github\.com/([^/\s\"']+/[^/\s\"']+)", text)
    return match.group(1).removesuffix(".git") if match else None


def detect_npm_package(text: str) -> str | None:
    match = re.search(r"registry\.npmjs\.org/((?:@[^/]+/)?[^/\s\"']+?)/-", text)
    if match:
        pkg = match.group(1)
        return pkg
    match = re.search(r"registry\.npmjs\.org/((?:@[^/]+/)?[^/\s\"']+)", text)
    return match.group(1) if match else None


def update_formula(path: Path, apply: bool) -> str:
    text = path.read_text()
    rel = path.relative_to(ROOT)
    npm_pkg = detect_npm_package(text)
    if npm_pkg:
        try:
            version, tarball, _ = npm_latest(npm_pkg)
        except Exception as error:
            return f"ERROR {rel} {error!r:.60}"
        old_match = re.search(r'(?m)^\s*version "([^"]+)"', text)
        old_version = old_match.group(1) if old_match else None
        new = re.sub(r'(?m)^(\s*version ")[^"]+("\s*)$', lambda m: f'{m.group(1)}{version}{m.group(2)}', text)
        # refresh concrete tarball url lines (main url + livecheck); #{version} templates untouched
        new = re.sub(
            r'(?m)^(\s*url ")https://registry\.npmjs\.org/[^"#{]+\.tgz("\s*)$',
            lambda m: f'{m.group(1)}{tarball}{m.group(2)}',
            new,
        )
        if version != old_version:
            try:
                sha = sha256_hex(tarball)
            except Exception as error:
                return f"ERROR {rel} {error!r:.60}"
            new, n = re.subn(
                r'(?m)^(\s*url ")https://registry\.npmjs\.org/[^"]+("\s*\n\s*sha256 ")[^"]+(")',
                lambda m: f'{m.group(1)}{tarball}{m.group(2)}{sha}{m.group(3)}',
                new,
            )

            def _tpl(m):
                concrete = m.group(2).replace("#{version}", version)
                return f"{m.group(1)}{m.group(2)}{m.group(3)}{sha256_hex(concrete)}{m.group(4)}"

            new, t = re.subn(
                r'(?m)^(\s*url ")([^"\n]*#\{version\}[^"\n]*)("\s*,?\s*\n(?:\s*using: [^\n]*\n)?\s*sha256 ")[^"]+(")',
                _tpl,
                new,
            )
            if n == 0 and t == 0:
                return f"ERROR {rel} no npm url+sha256 pair found"
        if new != text:
            if apply:
                path.write_text(new)
            return f"UPDATE {rel} -> {version}"
        return f"OK    {rel} ({version})"
    repo = detect_github_repo(text)
    if not repo:
        return f"SKIP  {rel} (no npm/github source)"
    try:
        version, checksums = github_release(repo)
    except Exception as error:
        return f"ERROR {rel} {error!r:.60}"
    assets = set(re.findall(r"/releases/download/[^/]+/([^\"/]+)", text))
    old_match = re.search(r'(?m)^\s*version "([^"]+)"', text)
    old_version = old_match.group(1) if old_match else None
    new = re.sub(r'(?m)^(\s*version ")[^"]+("\s*)$', lambda m: f'{m.group(1)}{version}{m.group(2)}', text)
    subs = 0
    for asset in assets:
        if asset not in checksums:
            continue
        new, k = re.subn(
            rf'(?m)(^\s*url "[^"]*/releases/download/)[^/]+(/[^"]*{re.escape(asset)}[^"]*"\s*\n\s*sha256 ")[^"]+(")',
            lambda m, a=asset: f'{m.group(1)}v{version}{m.group(2)}{checksums[a]}{m.group(3)}',
            new,
        )
        subs += k
    if version != old_version and subs == 0:
        return f"SKIP  {rel} (v{version} has no matching release assets)"
    if new != text:
        if apply:
            path.write_text(new)
        return f"UPDATE {rel} -> {version}"
    return f"OK    {rel} ({version})"


def update_bucket(path: Path, apply: bool) -> str:
    text = path.read_text()
    rel = path.relative_to(ROOT)
    npm_pkg = detect_npm_package(text)
    if npm_pkg:
        try:
            version, tarball, _ = npm_latest(npm_pkg)
        except Exception as error:
            return f"ERROR {rel} {error!r:.60}"
        old_match = re.search(r'"version"\s*:\s*"([^"]+)"', text)
        old_version = old_match.group(1) if old_match else None
        new = re.sub(r'("version"\s*:\s*")[^"]+(")', lambda m: f'{m.group(1)}{version}{m.group(2)}', text)
        if version != old_version:
            try:
                sha = sha256_hex(tarball)
            except Exception as error:
                return f"ERROR {rel} {error!r:.60}"

            def _pair(m, tarball=tarball, sha=sha):
                return f"{m.group(1)}{tarball}{m.group(2)}{sha}{m.group(3)}"

            new, n = re.subn(
                r'("url"\s*:\s*")https://registry\.npmjs\.org/[^"$]+?\.tgz("\s*,\s*\n\s*"hash"\s*:\s*")[^"]+(")',
                _pair,
                new,
                count=1,
            )
            if n == 0:
                # manifest without a hash field
                new, m_ct = re.subn(
                    r'("url"\s*:\s*")https://registry\.npmjs\.org/[^"$]+?\.tgz(")',
                    lambda m: f"{m.group(1)}{tarball}{m.group(2)}",
                    new,
                    count=1,
                )
                if m_ct == 0:
                    return f"ERROR {rel} no main npm url found"
        if new != text:
            if apply:
                path.write_text(new)
            return f"UPDATE {rel} -> {version}"
        return f"OK    {rel} ({version})"
    repo = detect_github_repo(text)
    if not repo:
        return f"SKIP  {rel} (no npm/github source)"
    try:
        version, checksums = github_release(repo)
    except Exception as error:
        return f"ERROR {rel} {error!r:.60}"
    old_match = re.search(r'"version"\s*:\s*"([^"]+)"', text)
    old_version = old_match.group(1) if old_match else None
    new = re.sub(r'("version"\s*:\s*")[^"]+(")', lambda m: f'{m.group(1)}{version}{m.group(2)}', text)
    subs = 0
    for asset, checksum in checksums.items():
        if asset not in new:
            continue

        def _repl(m, version=version, checksum=checksum):
            if "$version" in m.group(0):
                return m.group(0)
            return f"{m.group(1)}v{version}{m.group(2)}{checksum}{m.group(3)}"

        new, k = re.subn(
            rf'("url"\s*:\s*"[^"]*/releases/download/)[^/]+(/[^"]*{re.escape(asset)}[^"]*"\s*,\s*\n\s*"hash"\s*:\s*")[^"]+(")',
            _repl,
            new,
        )
        subs += k
    if version != old_version and subs == 0:
        return f"SKIP  {rel} (v{version} has no matching release assets)"
    if new != text:
        if apply:
            path.write_text(new)
        return f"UPDATE {rel} -> {version}"
    return f"OK    {rel} ({version})"


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--apply", action="store_true", help="write changes; default only reports")
    args = parser.parse_args()

    results = []
    for path in sorted(FORMULA.glob("*.rb")):
        results.append(update_formula(path, args.apply))
    for path in sorted(BUCKET.glob("*.json")):
        results.append(update_bucket(path, args.apply))

    for line in results:
        print(line)
    updated = sum(1 for r in results if r.startswith("UPDATE"))
    errors = sum(1 for r in results if r.startswith("ERROR"))
    skipped = sum(1 for r in results if r.startswith("SKIP"))
    print(f"\n{updated} updated, {errors} errors, {skipped} skipped, {len(results)} total")
    return 1 if errors else 0


if __name__ == "__main__":
    raise SystemExit(main())
