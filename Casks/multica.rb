cask "multica" do
  version "0.4.38"

  on_arm do
    sha256 "ef96bd9eac7e8aabd627a932a1d87ee8df2bee6e18ce506e71aea5f732f11482"

    url "https://github.com/multica-ai/multica/releases/download/v#{version}/multica-desktop-#{version}-mac-arm64.dmg"
  end
  on_intel do
    sha256 "cec748fa8f2cf5b1259397ab6611c1fc5ce229681c25a19c87748de19df9b4bb"

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
