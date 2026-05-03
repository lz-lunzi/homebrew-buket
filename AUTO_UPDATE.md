# 自动更新说明

## Homebrew 官方 Actions

本仓库使用 `Homebrew/actions/bump-packages` 实现自动化更新，该 Action 同时支持 Formula 和 Cask：

| Action | 用途 |
|--------|------|
| `setup-homebrew` | 安装和配置 Homebrew 环境 |
| `bump-packages` | 自动检测并更新 Formula 和 Cask 版本 |

> **注意**: `bump-formulae` 已废弃，`bump-cask-pr` 不存在。均已被 `bump-packages` 替代。

## 自动更新工作流

### 配置文件

`.github/workflows/auto-update.yml`

- **触发条件**：
  - 每 3 天 09:00 (北京时间) 自动运行
  - 支持手动触发 (`workflow_dispatch`)

- **更新流程**：
  1. 设置 Homebrew 环境 (`setup-homebrew`)
  2. 使用 `bump-packages` 自动检测并更新 Formula 和 Cask

- **前置条件**：
  - 需要配置 `HOMEBREW_GITHUB_API_TOKEN` Secret（需要比默认 `GITHUB_TOKEN` 更高权限的 Personal Access Token，用于创建 PR）

### 支持的自动更新

#### Formula
- ✅ **codebuddy-code**: npm 包，自动检测版本
- ✅ **iflow-cli**: npm 包，自动检测版本
- ✅ **octopus**: GitHub releases，自动检测版本

#### Cask
- ✅ **quotio**: GitHub releases，自动检测
- ✅ **github-store**: GitHub releases，自动检测
- ✅ **flclash**: GitHub releases，自动检测
- ⚠️ **codebuddy / codebuddy-cn**: CDN 分发，有限支持
- ⚠️ **z-code**: CDN 分发，有限支持
- ⚠️ **xterminal**: CDN 分发，有限支持
- ⚠️ **qodercli**: livecheck 已禁用，有限支持
- ⚠️ **zenflow**: 动态版本 (`:latest`)，无法追踪版本变更

### 手动更新流程

当自动更新无法工作时：

1. 从官网或 GitHub releases 获取最新版本号
2. 更新对应的 `.rb` 文件中的 `version` 字段
3. 获取下载文件的 SHA256（如果需要）
4. 提交并推送到 GitHub

```bash
# 获取 SHA256 示例
curl -sL <download-url> | shasum -a 256
```

### 用户更新方式

```bash
# 更新 Homebrew
brew update

# 升级所有应用
brew upgrade

# 升级特定应用
brew upgrade iflow-cli
brew upgrade --cask github-store
```
