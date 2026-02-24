# 自动更新说明

## Homebrew 官方 Actions 支持

本仓库使用 Homebrew 官方 Actions 实现自动化更新：

| Action | 用途 | 使用场景 |
|--------|------|----------|
| `setup-homebrew` | 安装和配置 Homebrew | 初始化环境 |
| `bump-formulae` | 自动检测并更新 Formula 版本 | 更新 npm 包等 |
| `bump-cask-pr` | 自动更新 Cask 版本 | 更新 GUI 应用 |
| `sync-tap` | 同步 tap 仓库 | 确保仓库最新状态 |

## 自动更新工作流

### 配置文件

`.github/workflows/auto-update.yml` 集成了所有官方 Actions：

- **触发条件**：
  - 每 10 天 09:00 (北京时间) 自动运行
  - 支持手动触发 (`workflow_dispatch`)

- **更新流程**：
  1. 设置 Homebrew 环境 (`setup-homebrew`)
  2. 自动更新 Formula (`bump-formulae`)
  3. 自动更新 Cask (`bump-cask-pr`)
  4. 同步 tap 仓库 (`sync-tap`)

### 支持的自动更新

#### Formula (自动更新支持)
- ✅ **iflow-cli**: npm 包，自动检测版本
- ✅ **qoder-cli**: npm 包，自动检测版本

#### Cask (自动更新支持)
- ✅ **quotio**: GitHub releases，自动检测
- ✅ **github-store**: GitHub releases，自动检测
- ✅ **flclash**: GitHub releases，自动检测
- ⚠️ **codebuddy / codebuddy-cn**: CDN 分发，有限支持
- ⚠️ **z-code**: CDN 分发，有限支持
- ⚠️ **xterminal**: CDN 分发，有限支持
- ⚠️ **zenflow**: 动态版本，有限支持

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

## 旧版工作流

原 `bump-casks.yml` 已被 `auto-update.yml` 替代，提供更全面的自动更新支持。
