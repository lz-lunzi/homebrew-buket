# homebrew-buket

Homebrew Tap 仓库，包含实用工具的 Casks 和 Formulas

## 可用工具

### ToDesk - 远程桌面软件

[ToDesk](https://www.todesk.com/) 是一款免费、安全、流畅的远程桌面软件，支持跨平台连接，提供高性能远程控制体验。

**主要功能：**
- 超强性能：最高支持 8K 和 360FPS 帧率画质，<3ms 超低延迟
- 隐私保护：隐私屏防窥和远程关闭物理屏
- 外设映射：支持映射游戏手柄、数位板、游戏鼠标、摄像头、麦克风
- 全平台覆盖：Win/Mac/Linux/Android/iOS/鸿蒙
- 高速文件传输：支持拖拽与复制粘贴，专享高速服务器
- 安全守护：移动端主设备二次验证
- 多屏协作与虚拟屏：自由驾驭多屏电脑和支持虚拟屏

### XTerminal - 现代化终端管理工具

[XTerminal](https://www.terminal.icu/) 是一款现代化跨平台终端管理工具，专为需要管理多台服务器的开发者、运维工程师和系统管理员设计。

**主要功能：**
- SSH 终端：支持密码、秘钥、登录凭证等多种验证方式
- SFTP 文件传输：图形化文件浏览器，拖拽上传下载
- 端口转发：本地转发、远程转发、动态代理（SOCKS5）
- 本地终端：直接操作本机 Shell
- AI 助手：内置 AI 对话能力，命令解释与生成
- 服务器资源监控：CPU/内存/磁盘/网络实时监控

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

### CodeBuddy - AI 智能编程助手

[CodeBuddy](https://www.codebuddy.ai/ide) 是一款强大的 AI 编程助手，提供智能代码补全和上下文感知的代码生成能力，帮助你更高效地完成编程任务。

**主要功能：**
- 智能代码补全：基于上下文实时生成代码建议
- 多语言支持：支持多种编程语言和框架
- 上下文感知代码生成：理解项目结构，生成高质量代码
- 实时代码分析：自动检测代码问题并提供优化建议
- AI 辅助调试：智能诊断错误并提供解决方案

## 安装

1. 添加 tap 仓库：

```bash
brew tap lz-lunzi/homebrew-buket
```

2. 安装工具：

```bash
# 安装 ToDesk
brew install --cask todesk

# 安装 XTerminal
brew install --cask xterminal

# 安装 Z Code
brew install --cask z-code

# 安装 Quotio
brew install --cask quotio

# 安装 CodeBuddy
brew install --cask codebuddy
```

## 升级

```bash
# 升级 ToDesk
brew upgrade --cask todesk

# 升级 XTerminal
brew upgrade --cask xterminal

# 升级 Z Code
brew upgrade --cask z-code

# 升级 Quotio
brew upgrade --cask quotio

# 升级 CodeBuddy
brew upgrade --cask codebuddy
```

## 卸载

```bash
# 卸载 ToDesk
brew uninstall --cask todesk

# 卸载 XTerminal
brew uninstall --cask xterminal

# 卸载 Z Code
brew uninstall --cask z-code

# 卸载 Quotio
brew uninstall --cask quotio

# 卸载 CodeBuddy
brew uninstall --cask codebuddy
```

## 其他工具

### Qoder CLI（示例）

这是 qoder CLI 的 Formula 示例，展示了如何创建 Homebrew Formula。注意：

- qoder CLI 官方 tap：`brew install qoderai/qoder/qodercli --cask`
- 实际使用时，请访问 [qoder.com/cli](https://qoder.com/cli) 获取官方安装方式

## 官方文档

- [ToDesk 官网](https://www.todesk.com/)
- [XTerminal 官网](https://www.terminal.icu/)
- [Z Code 官网](https://zcode-ai.com/cn)
- [Quotio GitHub](https://github.com/nguyenphutrong/quotio)
- [CodeBuddy 官网](https://www.codebuddy.ai/ide)
- [Qoder CLI 文档](https://docs.qoder.com/cli)
