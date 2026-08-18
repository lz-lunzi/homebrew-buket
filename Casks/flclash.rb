cask "flclash" do
  version "0.8.96"
  sha256 :no_check

  on_arm do
    url "https://github.com/chen08209/FlClash/releases/download/v0.8.92/FlClash-0.8.92-macos-arm64.dmg"
  end
  on_intel do
    url "https://github.com/chen08209/FlClash/releases/download/v0.8.92/FlClash-0.8.92-macos-amd64.dmg"
  end

  name "FlClash"
  desc "Multi-platform proxy client based on ClashMeta"
  homepage "https://github.com/chen08209/FlClash"

  livecheck do
    url "https://github.com/chen08209/FlClash/releases"
    strategy :github_latest
  end

  depends_on macos: :big_sur

  app "FlClash.app"

  caveats <<~EOS
    FlClash is a multi-platform proxy client based on ClashMeta.

    Features:
    - Multi-platform: Android, Windows, macOS and Linux
    - Adaptive multiple screen sizes, Multiple color themes available
    - Based on Material You Design, Surfboard-like UI
    - Supports data sync via WebDAV
    - Support subscription link, Dark mode
  EOS
end
