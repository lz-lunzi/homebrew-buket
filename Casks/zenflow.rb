cask "zenflow" do
  version :latest
  sha256 :no_check

  url "https://download.zencoder.ai/zenflowapp/latest/darwin-arm64/Zenflow.dmg",
      verified: "download.zencoder.ai/zenflowapp/"
  name "Zenflow"
  desc "Multi-agent orchestration platform for AI software development"
  homepage "https://zencoder.ai/"

  app "Zenflow.app"

  caveats <<~EOS
    Zenflow is an AI orchestration platform that provides:
    - Spec-driven workflows for AI engineering
    - Multi-agent coordination and execution
    - Built-in verification and quality checks
    - Integration with IDEs and CI/CD tools
    - 24/7 autonomous agent capabilities

    Visit https://zencoder.ai for more information.
  EOS
end
