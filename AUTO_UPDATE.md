# 自动更新说明

## Homebrew Cask 自动更新机制

Homebrew casks 本身已经内置了自动检查更新功能。用户只需要运行：

```bash
# 检查所有已安装 casks 的更新
brew update

# 升级所有可更新的 casks
brew upgrade --cask

# 升级特定的 cask
brew upgrade --cask quotio
brew upgrade --cask z-code
brew upgrade --cask xterminal
brew upgrade --cask todesk
```

## GitHub Actions 自动更新

如果你想通过 GitHub Actions 自动更新版本并提交到仓库，可以使用以下 workflow：

### 当前限制

由于这些工具的发布渠道不同：
- **Quotio**: GitHub releases（可自动获取）
- **Z Code**: 官网 CDN（需要 HTML 解析）
- **XTerminal**: CDN（需要 HTML 解析）
- **ToDesk**: 动态 PKG（不支持版本固定）

### 简化的自动更新方案

对于 Quotio 这样有 GitHub releases 的项目，可以自动更新。对于其他项目，需要手动维护版本号。

### 推荐做法

1. **日常维护**：当发现新版本时，手动更新 cask 文件
2. **使用 `:latest`**：对于动态生成的文件（如 ToDesk）
3. **固定版本号**：对于稳定的发布（如 Quotio, Z Code, XTerminal）

## 手动更新流程

1. 从官网或 GitHub releases 获取最新版本号
2. 更新 `Casks/*.rb` 中的 `version` 字段
3. 获取下载文件的 SHA256（如果需要）
4. 提交并推送到 GitHub
5. 用户运行 `brew upgrade` 获取更新
