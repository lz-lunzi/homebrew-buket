cask "ima" do
  version "2.3.0"
  sha256 "877f13a179ad9688164a7bcf3d8ba691968277e85cfcaad67c0fb93e24af011d"

  url "https://ima-app.image.myqcloud.com/app/ima.copilot_universal_1018_2.3.0_3717.dmg"
  name "ima"
  desc "Tencent AI knowledge manager and copilot"
  homepage "https://ima.qq.com/"

  livecheck do
    skip "No public version API; version is embedded in SPA JS bundle"
  end

  depends_on macos: :monterey

  app "ima.app"

  zap trash: [
    "~/Library/Application Support/ima",
    "~/Library/Caches/ima",
    "~/Library/Preferences/com.tencent.ima.plist",
  ]
end
