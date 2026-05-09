cask "ccnexus" do
  version "5.2.0"
  sha256 :no_check

  url "https://github.com/lich0821/ccNexus/releases/download/v#{version}/ccNexus-v#{version}-darwin-arm64.zip"
  name "ccNexus"
  desc "Smart API gateway for Claude Code and Codex CLI with GUI"
  homepage "https://github.com/lich0821/ccNexus"

  livecheck do
    url "https://github.com/lich0821/ccNexus/releases"
    strategy :github_latest
  end

  depends_on macos: ">= :big_sur"
  depends_on arch: :arm64

  app "ccNexus.app"

  caveats <<~EOS
    ccNexus is a smart API gateway for Claude Code and Codex CLI with GUI.

    Features:
    - Multi-endpoint rotation with automatic failover
    - API format conversion (Claude/OpenAI/Gemini)
    - Codex Token Pool management
    - Real-time usage statistics

    Configuration for Claude Code (~/.claude/settings.json):
      "ANTHROPIC_BASE_URL": "http://127.0.0.1:3000"

    Configuration for Codex CLI (~/.codex/config.toml):
      base_url = "http://127.0.0.1:3000"

    The gateway runs at: http://127.0.0.1:3000

    Note: If macOS shows "app is damaged", run:
      xattr -cr /Applications/ccNexus.app

    For more information, visit: https://github.com/lich0821/ccNexus
  EOS
end
