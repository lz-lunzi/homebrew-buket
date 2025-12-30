# homebrew-buket

Homebrew Tap 仓库，包含实用工具的 Casks 和 Formulas

## 可用工具

### Z Code - AI 编程平台

[Z Code](https://zcode-ai.com/cn) 是一个简单、快速、即时可用的 AI 编程平台，将最强大的 AI Agents 与现有工具链结合，让你在熟悉的流程中完成规划、编码、评审与上线。

**主要功能：**
- 全局理解代码库：跨仓库追踪上下文，为整条技术栈提供一致的代码理解能力
- 自动化代码评审：在创建 PR 之前就给出内联建议，提前发现风险和回归问题
- 无缝集成现有流程：与现有编辑器、任务系统和发布流水线兼容
- 实时协作：保持在技术前沿，让团队保持高效和稳健

### Quotio - AI 编程助手管理器

[Quotio](https://github.com/nguyenphutrong/quotio) 是一个原生的 macOS 菜单栏应用，用于统一管理多个 AI 账户（Claude、Gemini、OpenAI、Qwen、Antigravity 等），提供实时配额追踪和智能故障转移。

**主要功能：**
- 多提供商支持：Claude、Gemini、OpenAI Codex、Qwen、Vertex AI 等
- 实时仪表盘：监控请求流量、令牌使用和成功率
- 智能配额管理：可视化配额追踪和自动故障转移策略
- 菜单栏集成：快速访问服务器状态和配额概览
- 代理配置：自动配置 AI 编程工具（Claude Code、OpenCode 等）

## 安装

1. 添加 tap 仓库：

```bash
brew tap lz-lunzi/homebrew-buket
```

2. 安装工具：

```bash
# 安装 Z Code
brew install --cask z-code

# 安装 Quotio
brew install --cask quotio
```

## 升级

```bash
# 升级 Z Code
brew upgrade --cask z-code

# 升级 Quotio
brew upgrade --cask quotio
```

## 卸载

```bash
# 卸载 Z Code
brew uninstall --cask z-code

# 卸载 Quotio
brew uninstall --cask quotio
```

## 其他工具

### Qoder CLI（示例）

这是 qoder CLI 的 Formula 示例，展示了如何创建 Homebrew Formula。注意：

- qoder CLI 官方 tap：`brew install qoderai/qoder/qodercli --cask`
- 实际使用时，请访问 [qoder.com/cli](https://qoder.com/cli) 获取官方安装方式

## 官方文档

- [Z Code 官网](https://zcode-ai.com/cn)
- [Quotio GitHub](https://github.com/nguyenphutrong/quotio)
- [Qoder CLI 文档](https://docs.qoder.com/cli)
