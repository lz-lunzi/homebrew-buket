# 自动更新说明

## 使用的 Homebrew 命令

本仓库逐个 formula/cask 调用官方命令检测并更新版本：

| 命令 | 用途 |
|--------|------|
| `setup-homebrew` (Action) | 安装和配置 Homebrew 环境 |
| `brew bump-formula-pr --write-only` | 检测并更新单个 Formula 版本 |
| `brew bump-cask-pr --write-only` | 检测并更新单个 Cask 版本 |

## 自动更新工作流

### 配置文件

`.github/workflows/auto-update.yml`

- **触发条件**：
  - 每天 09:00 (北京时间) 自动运行
  - 支持手动触发 (`workflow_dispatch`)

- **更新流程**：
  1. 设置 Homebrew 环境 (`setup-homebrew`)
  2. 逐个调用 `brew bump-formula-pr` / `brew bump-cask-pr` 检测并更新

- **前置条件**：
  - 需要配置 `HOMEBREW_GITHUB_API_TOKEN` Secret（需要比默认 `GITHUB_TOKEN` 更高权限的 Personal Access Token，用于创建 PR）

### 支持的自动更新

#### Formula
agentsync、bifrost、codebuddy-code、litellm、nine_remote、nine_router、octopus、oh-my-openagent、omniroute、omp、pm2、qodercli、relayplane、trae-cli

#### Cask
ai-gateway、codebuddy-cn、flclash、github-store、nyro、otty、quotio、skills-manage、skills-manager、v2rayn、xterminal、z-code、zenflow

> ⚠️ **otty**：版本为 `:latest`，无法追踪版本变更，自动更新会跳过。
> ⚠️ **codebuddy-cn / z-code / xterminal**：CDN 分发，livecheck 有限支持。
> ⚠️ **qodercli**：livecheck 依赖 release 页面正则，可能不稳定。

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
brew upgrade omp
brew upgrade --cask github-store
```
