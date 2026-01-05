cask "flclash" do
  version "0.8.91"
  sha256 :no_check

  on_arm do
    url "https://github.com/chen08209/FlClash/releases/download/v#{version}/FlClash-#{version}-macos-arm64.dmg",
        verified: "github.com/chen08209/FlClash/"
  end
  on_intel do
    url "https://github.com/chen08209/FlClash/releases/download/v#{version}/FlClash-#{version}-macos-amd64.dmg",
        verified: "github.com/chen08209/FlClash/"
  end

  name "FlClash"
  desc "A multi-platform proxy client based on ClashMeta, simple and easy to use, open-source and ad-free"
  homepage "https://github.com/chen08209/FlClash"

  depends_on macos: ">= :big_sur"

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

