cask "qwenwork" do
  arch arm: "arm64", intel: "x64"

  version "0.1.8"
  sha256 :no_check

  url "https://assets.qwenwork.cn/release/latest/qwenworkcn-darwin-#{arch}.dmg"
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
