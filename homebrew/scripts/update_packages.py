#!/usr/bin/env python3
"""Scan all Formula/*.rb and bucket/*.json, detect package sources,
fetch latest versions + checksums, and update version + sha256/hash.

Priority: npm registry > GitHub releases.
GitHub only used when file has /releases/download/ URLs.

Dry-run by default. Use --apply to write files.
"""
from __future__ import annotations

import argparse
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
        new = re.sub(r'(?m)^(\s*version ")[^"]+("\s*)$', lambda m: f'{m.group(1)}{version}{m.group(2)}', text)
        new = re.sub(r'(?m)^(\s*url ")[^"]+("\s*)$', lambda m: f'{m.group(1)}{tarball}{m.group(2)}', new)
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
    new = re.sub(r'(?m)^(\s*version ")[^"]+("\s*)$', lambda m: f'{m.group(1)}{version}{m.group(2)}', text)
    for asset in assets:
        if asset not in checksums:
            continue
        new = re.sub(
            rf'(?m)(^\s*url "[^"]*/releases/download/)[^/]+(/[^"]*{re.escape(asset)}[^"]*"\s*\n\s*sha256 ")[^"]+(")',
            rf"\g<1>v{version}\g<2>{checksums[asset]}\g<3>",
            new,
        )
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
        new = re.sub(r'("version"\s*:\s*")[^"]+(")', lambda m: f'{m.group(1)}{version}{m.group(2)}', text)
        new = re.sub(r'("url"\s*:\s*")[^"]+(")', lambda m: f'{m.group(1)}{tarball}{m.group(2)}', new)
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
    new = re.sub(r'("version"\s*:\s*")[^"]+(")', lambda m: f'{m.group(1)}{version}{m.group(2)}', text)
    for asset, checksum in checksums.items():
        if asset not in new:
            continue
        new = re.sub(
            rf'("url"\s*:\s*"[^"]*/releases/download/)[^/]+(/[^"]*{re.escape(asset)}[^"]*"\s*,\s*\n\s*"hash"\s*:\s*")[^"]+(")',
            rf"\g<1>v{version}\g<2>{checksum}\g<3>",
            new,
        )
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
