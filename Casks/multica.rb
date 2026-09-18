cask "multica" do
  version "0.5.0"

  on_arm do
    sha256 "2872832cd3636b57def509a905593acf3c8c5247316b38b8c1168ace6c7d661a"

    url "https://github.com/multica-ai/multica/releases/download/v#{version}/multica-desktop-#{version}-mac-arm64.dmg"
  end
  on_intel do
    sha256 "53dac73b3293a59a3af12739acd63fd879cd700951fb5b51be961143ee4290d7"

    url "https://github.com/multica-ai/multica/releases/download/v#{version}/multica-desktop-#{version}-mac-x64.dmg"
  end

  name "Multica"
  desc "Local agent runtime and management tool for the Multica platform"
  homepage "https://github.com/multica-ai/multica"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on :macos

  app "Multica.app"

  zap trash: [
    "~/Library/Application Support/Multica",
    "~/Library/Caches/com.multica.desktop",
    "~/Library/Preferences/com.multica.desktop.plist",
    "~/Library/Saved Application State/com.multica.desktop.savedState",
  ]
end
