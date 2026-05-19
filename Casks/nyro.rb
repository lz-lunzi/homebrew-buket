cask "nyro" do
  version "1.7.5"
  sha256 :no_check

  on_arm do
    url "https://github.com/nyroway/nyro/releases/download/v#{version}/Nyro_#{version}_aarch64.dmg"
  end
  on_intel do
    url "https://github.com/nyroway/nyro/releases/download/v#{version}/Nyro_#{version}_x64.dmg"
  end

  name "Nyro"
  desc "Self-hosted AI Gateway with protocol translation"
  homepage "https://github.com/nyroway/nyro"

  livecheck do
    url "https://github.com/nyroway/nyro/releases"
    strategy :github_latest
  end

  depends_on macos: :big_sur

  app "Nyro.app"

  caveats <<~EOS
    Nyro - Self-hosted AI Gateway with protocol translation.

    Features:
    - Connect Claude Code, Codex, Gemini CLI and any SDK to any model provider
    - Protocol translation (OpenAI, Anthropic, Gemini)
    - Streaming SSE passthrough and cross-protocol format conversion
    - Desktop UI for provider, route, API key and usage management

    Default gateway: http://127.0.0.1:3000

    Configure Claude Code:
      export ANTHROPIC_BASE_URL=http://127.0.0.1:3000

    Configure Codex CLI:
      export OPENAI_BASE_URL=http://127.0.0.1:3000/v1

    Docs: https://github.com/nyroway/nyro
  EOS
end
