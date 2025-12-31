# 自动更新说明

## Homebrew Cask 自动更新机制

### 内置更新功能

Homebrew casks 已经内置了自动检查更新功能。用户只需要运行：

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

### GitHub Actions 自动更新

已配置 `.github/workflows/bump-casks.yml`，使用 Homebrew 官方的 `bump-formulae` action 自动检测版本更新。

**工作原理**：
- 每 6 小时自动运行一次
- 检测各 cask 的最新版本
- 自动创建 Pull Request 到你的 tap 仓库

**注意事项**：
- `bump-formulae` action 主要为 formula 设计，对 cask 支持有限
- 需要在 GitHub 仓库中设置 `GITHUB_TOKEN` secret
- 对于没有 GitHub releases 的工具（如 Z Code, XTerminal），可能无法自动检测

### 手动更新流程

当 GitHub Actions 无法自动更新时，可以手动维护：

1. 从官网或 GitHub releases 获取最新版本号
2. 更新 `Casks/*.rb` 中的 `version` 字段
3. 获取下载文件的 SHA256（如果需要）
4. 提交并推送到 GitHub
5. 用户运行 `brew upgrade` 获取更新

### 各工具更新策略

| 工具 | 发布渠道 | 自动更新 | 说明 |
|------|---------|---------|------|
| Quotio | GitHub releases | ✅ 支持 | 可自动检测并 PR |
| Z Code | 官网 CDN | ⚠️ 有限 | 需要 HTML 解析 |
| XTerminal | CDN | ⚠️ 有限 | 需要 HTML 解析 |
| ToDesk | 动态 PKG | ❌ 不支持 | 文件每次不同 |

### 推荐做法

1. **依赖 GitHub Actions**：大部分更新自动完成
2. **定期检查**：关注各工具的 GitHub releases 或官网
3. **响应 PR**：及时 review 并合并自动创建的 PR
4. **用户通知**：在 README 中说明更新方式

### 本地测试更新

测试新的 cask 版本：

```bash
# 方法1: 强制重新安装
brew reinstall --cask <cask-name>

# 方法2: 先卸载再安装
brew uninstall --cask <cask-name>
brew install --cask <cask-name>

# 方法3: 清除缓存后升级
brew cleanup
brew upgrade --cask <cask-name>
```
