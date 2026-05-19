cask "omniroute" do
  version "3.7.9"
  sha256 :no_check

  on_arm do
    url "https://github.com/diegosouzapw/OmniRoute/releases/download/v#{version}/OmniRoute-#{version}-arm64.dmg"
  end
  on_intel do
    url "https://github.com/diegosouzapw/OmniRoute/releases/download/v#{version}/OmniRoute-#{version}.dmg"
  end

  name "OmniRoute"
  desc "Free AI gateway: one endpoint, 160+ providers, RTK+Caveman compression"
  homepage "https://github.com/diegosouzapw/OmniRoute"

  livecheck do
    url "https://github.com/diegosouzapw/OmniRoute/releases"
    strategy :github_latest
  end

  depends_on macos: :big_sur

  app "OmniRoute.app"

  caveats <<~EOS
    OmniRoute is a free AI gateway with one endpoint for 160+ providers.

    Features:
    - RTK+Caveman stacked compression (~95% context savings)
    - Smart auto-fallback
    - MCP/A2A support
    - Multimodal APIs
    - Desktop + PWA
  EOS
end
