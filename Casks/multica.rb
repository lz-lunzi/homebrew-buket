cask "multica" do
  version "0.4.24"

  on_arm do
    sha256 "ef405c6613513bde712b63ea9b99a6aa36c9dec50b5bfb0ad05c7e3b63a6ea8c"

    url "https://github.com/multica-ai/multica/releases/download/v#{version}/multica-desktop-#{version}-mac-arm64.dmg"
  end
  on_intel do
    sha256 "c261d6f814b1b72805f65b3b91540085dcb91a7e3e2016f141fea2fa2261ef38"

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
