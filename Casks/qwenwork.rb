cask "qwenwork" do
  arch arm: "arm64", intel: "x64"

  version "0.1.8"
  sha256 arm:   "4b344b28b6fa881da5741caad55b5864c0b8c15a39d84f2c1ae1a206d8969a9a",
         intel: "c5366f511ad93c9236f78d0e5f5594c6ff1d5c01f6c9ea496de274df6e1c04fc"

  url "https://assets.qwenwork.cn/release/latest/qwenworkcn-darwin-#{arch}.dmg",
      verified: "assets.qwenwork.cn/release/"
  name "QwenWorkCN"
  desc "AI-powered office assistant (千问办公)"
  homepage "https://qwenwork.cn/"

  livecheck do
    skip "No public version API; download URL uses /latest/ path without version info"
  end

  depends_on macos: :big_sur

  app "QwenWorkCN.app"

  zap trash: [
    "~/Library/Application Support/QwenWorkCN",
    "~/Library/Caches/cn.qwenwork.desktop.mac",
    "~/Library/Preferences/cn.qwenwork.desktop.mac.plist",
    "~/Library/Saved Application State/cn.qwenwork.desktop.mac.savedState",
  ]
end
