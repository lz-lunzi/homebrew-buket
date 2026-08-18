cask "multica" do
  version "0.4.28"

  on_arm do
    sha256 "db617eb1bf537423a562f595a0659f87f14d93f2dd3e6ea0b0119c1a641196df"

    url "https://github.com/multica-ai/multica/releases/download/v#{version}/multica-desktop-#{version}-mac-arm64.dmg"
  end
  on_intel do
    sha256 "9460f0c7c88cbeb3a2e4ea04cece7d997a824490dfcda4f8ff60ff3c4968c92e"

    url "https://github.com/multica-ai/multica/releases/download/v#{version}/multica-desktop-#{version}-mac-x64.dmg"
  end

  name "Multica"
  desc "Local agent runtime and management tool for the Multica platform"
  homepage "https://github.com/multica-ai/multica"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :big_sur

  app "Multica.app"

  zap trash: [
    "~/Library/Application Support/Multica",
    "~/Library/Caches/com.multica.desktop",
    "~/Library/Preferences/com.multica.desktop.plist",
    "~/Library/Saved Application State/com.multica.desktop.savedState",
  ]
end
