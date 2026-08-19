cask "workbuddy" do
  arch arm: "arm64", intel: "x64"

  version "5.3.14.36279234,825709d4"
  sha256 arm:   "02cad11bf47a9db8bc0ea3bddd7661b52bb83b809509d11a3400dcfad602880b",
         intel: "25fe856763ff917e3086135f445c1016085ef7130433661994840e7a4c0a09ce"

  url "https://download.codebuddy.cn/workbuddy/saas/darwin-#{arch}/WorkBuddy-darwin-#{arch}-#{version.csv.first}-#{version.csv.second}.zip",
      verified: "download.codebuddy.cn/workbuddy/"
  name "WorkBuddy"
  desc "AI-powered work assistant from Tencent"
  homepage "https://www.codebuddy.cn/"

  livecheck do
    url "https://copilot.tencent.com/v2/update?platform=workbuddy-darwin-#{arch}&version=1.0.0&x-machine-id=default"
    regex(%r{/WorkBuddy[._-]darwin[._-]#{arch}[._-]v?(\d+(?:\.\d+)+)-(\h+)\.zip}i)
    strategy :json do |json, regex|
      match = json["url"]&.match(regex)
      next if match.blank?

      "#{match[1]},#{match[2]}"
    end
  end

  auto_updates true
  depends_on macos: :big_sur

  app "WorkBuddy.app"

  zap trash: [
    "~/.workbuddy",
    "~/Library/Application Support/WorkBuddy",
    "~/Library/Caches/com.workbuddy.workbuddy",
    "~/Library/Caches/com.workbuddy.workbuddy.ShipIt",
    "~/Library/Preferences/com.workbuddy.workbuddy.plist",
    "~/Library/Saved Application State/com.workbuddy.workbuddy.savedState",
  ]
end
