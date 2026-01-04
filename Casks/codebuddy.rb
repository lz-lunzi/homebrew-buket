cask "codebuddy" do
  version "4.2.2.16135922"
  sha256 :no_check

  url "https://codebuddy-1328495429.cos.accelerate.myqcloud.com/aiide/darwin-arm64/CodeBuddy-darwin-arm64-#{version}-ac46abb397-d4a42927.dmg",
      verified: "codebuddy-1328495429.cos.accelerate.myqcloud.com"
  name "CodeBuddy"
  desc "AI-powered IDE assistant with intelligent code completion and suggestions"
  homepage "https://www.codebuddy.ai/ide"

  app "CodeBuddy.app"

  caveats <<~EOS
    CodeBuddy is an AI-powered IDE assistant that provides:
    - Intelligent code completion and suggestions
    - Multi-language support for various programming languages
    - Context-aware code generation
    - Real-time code analysis and optimization
    - AI-assisted debugging and error resolution
  EOS
end
