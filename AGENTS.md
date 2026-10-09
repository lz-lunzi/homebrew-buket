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

## Scoop 便携化（Portable）规范

目标：解压即用、数据全落 `persist`、卸载零残留、目录可整体迁移。

### 包形态优先级与提取方式

| 官方发布形态 | manifest 写法 | Scoop 提取引擎 |
|---|---|---|
| zip/7z 便携包（首选） | 直接 `url` + `extract_dir` | 7-Zip |
| NSIS 安装器 exe | `url` 加 `#/dl.7z` 后缀 | 7-Zip 强解 |
| Inno Setup 安装器 exe | `url` 保持 `.exe` + `"innosetup": true` | innounp |
| MSI | `url` 直接指 `.msi` | lessmsi（优先）/ `msiexec /a` 管理安装 |
| WiX Burn 捆绑 exe | `#/dl.7z` 常失败；用 `wix burn extract` 或 `dark.exe -x` 预解 | dark.exe |

### 便携化三板斧

1. **清残渣**：`pre_install` 删除 `$PLUGINSDIR`、`uninst*.exe`、`redist_packages` 等。
2. **持久化数据**：
   - 程序写自身目录 → `"persist": ["Config", "Data"]`
   - 程序写 `%APPDATA%` → `installer.script` 建 Junction 指向 `$persist_dir`（先迁移已有数据），卸载时 `uninstaller.script` 拆链接（模板见 `bucket/clash-verge-rev.json`）
3. **注册表/服务类软件**：无法真便携。`notes` 说明残留点，`pre_uninstall` 清理 HKCU 键值；确保非管理员可装可卸。

### MSI / 安装器 exe 的便携化边界

- MSI 提取（`msiexec /a` 或 lessmsi）只拿文件，**不执行 Custom Action**：COM 注册、服务、驱动、文件关联、运行库部署全部缺失。此类包（如 VirtualBox）要么放弃便携，要么 manifest 加依赖（`depends`）+ `installer` 脚本补注册。
- Burn 捆绑包内常嵌 MSI + VC 运行库，需逐层 `dark.exe -x` / `wix burn extract` 解出真实 payload。

### 自建便携版流程（官方无 portable 分发时）

1. `scoop install lessmsi innounp dark 7zip` 解出安装器内容（Scoop 遇到对应格式也会自动装这些 helper）
2. RegShot 快照安装前后 diff，找出注册表/文件残留点
3. 用 NSIS（开源 `makensis`）写 nullsoft 便携打包脚本，或直接重打 zip 放 GitHub Releases，manifest 的 `url` 指向该 release
4. 注册表依赖重的软件不强行便携；发布前用 `scoop checkup` + 干净虚拟机验证「装→用→卸→查残留」

### 参考样例

- 纯便携 + persist：`bucket/pixpin.json`
- 安装器强解 + APPDATA Junction：`bucket/clash-verge-rev.json`
- NSIS 强解 + 数据迁移：`bucket/NeteaseCloudMusic.json`
