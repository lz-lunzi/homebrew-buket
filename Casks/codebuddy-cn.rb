cask "codebuddy-cn" do
  version "4.2.3.16929265"
  sha256 :no_check

  url "https://acc-1258344699.cos.accelerate.myqcloud.com/aiide/darwin-arm64/CodeBuddy-darwin-arm64-#{version}-8da5bbfef2-a50b9bce-cn.dmg",
      verified: "acc-1258344699.cos.accelerate.myqcloud.com"
  name "CodeBuddy_CN"
  desc "AI-powered IDE assistant with intelligent code completion and suggestions (China version)"
  homepage "https://www.codebuddy.ai/ide"

  # DMG 内部应用名为 "CodeBuddy CN.app"，安装后重命名避免与官方版冲突
  app "CodeBuddy CN.app"
  caveats <<~EOS
    CodeBuddy_CN is an AI-powered IDE assistant that provides:
    - Intelligent code completion and suggestions
    - Multi-language support for various programming languages
    - Context-aware code generation
    - Real-time code analysis and optimization
    - AI-assisted debugging and error resolution
    - Optimized for users in China
  EOS
end

