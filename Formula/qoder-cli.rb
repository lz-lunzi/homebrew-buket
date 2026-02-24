cask "qodercli" do
  version "0.1.29"

  on_arm do
    sha256 "33f13311a5f6ab88f6c2c35475a0eac49822fb47046c4aa49b752599e46f1f17"
    url "https://download.qoder.com/qodercli/releases/#{version}/qodercli_#{version}_darwin_arm64.zip",
        verified: "download.qoder.com/qodercli/"
  end
  on_intel do
    sha256 "925790fb4c296a550e62a48de6d46942e5002024083ba8b3447db1dee4bc6a9c"
    url "https://download.qoder.com/qodercli/releases/#{version}/qodercli_#{version}_darwin_amd64.zip",
        verified: "download.qoder.com/qodercli/"
  end

  name "Qoder CLI"
  desc "Agentic AI coding platform for terminal-based development with spec-driven workflows and autonomous agents"
  homepage "https://qoder.com"

  binary "qodercli"

  zap trash: "~/.qoder"

  caveats <<~EOS
    Qoder CLI is an agentic AI coding platform that provides:
    - Nextnew: Predictive code completion with Tab
    - Agentic Chat: Collaborative AI planning and coding
    - Autonomous Agents: End-to-end task automation
    - Repo Wiki: Automated codebase documentation
    - MCP Support: Extensible capabilities via MCP tools

    Official installation method:
      curl -fsSL https://qoder.com/install | bash

    Visit https://qoder.com for more information.
  EOS
end
