cask "traework-cn" do
  arch arm: "arm64", intel: "x64"

  version "2.3.71801"
  sha256 arm:   "5b683886b3d1f0464912c93033ccf90d880adf242bb0020c27db1a5dfb67e322",
         intel: "fb0278252510a13eed4ced63f960e85ea77ca66c6880625d149c4109210484c7"

  url "https://lf-cdn.trae.com.cn/obj/trae-com-cn/pkg/app/releases/stable/#{version}/darwin/TraeWork_CN-darwin-#{arch}.dmg",
      verified: "lf-cdn.trae.com.cn/obj/trae-com-cn/pkg/app/releases/stable/"
  name "TraeWork CN"
  desc "AI-powered work platform by ByteDance (Chinese version)"
  homepage "https://www.trae.cn/work"

  livecheck do
    url "https://api.trae.cn/icube/api/v1/native/version/trae/cn/latest"
    strategy :json do |json|
      json.dig("data", "solo", "darwin", "version")
    end
  end

  auto_updates true
  depends_on macos: :monterey

  app "TRAE SOLO CN.app"

  zap trash: [
    "~/Library/Application Support/cn.trae.solo.app",
    "~/Library/Caches/cn.trae.solo.app",
    "~/Library/Preferences/cn.trae.solo.app.plist",
    "~/Library/Saved Application State/cn.trae.solo.app.savedState",
  ]
end
