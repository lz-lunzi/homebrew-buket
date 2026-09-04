cask "multica" do
  version "0.4.39"

  on_arm do
    sha256 "86e73aaa008f8f48b4107154bd45cd59ec2b7d4068b81dacf11bab194d65ef28"

    url "https://github.com/multica-ai/multica/releases/download/v#{version}/multica-desktop-#{version}-mac-arm64.dmg"
  end
  on_intel do
    sha256 "af3725e39389c663acccebf7330406ecf98a745a01524342552f47b552d3b92f"

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
