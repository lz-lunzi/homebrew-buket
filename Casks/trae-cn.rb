cask "trae-cn" do
  arch arm: "arm64", intel: "x64"

  version "2.3.90452"
  sha256 arm:   "62398d6a8622deb7ca633feb3d34db37ecf27b9e547774b11765af0d50818a28",
         intel: "c1740a4722b67362508d33d49714490ac44aef7abfe592eca096f2702264fb8f"

  url "https://lf-cdn.trae.com.cn/obj/trae-com-cn/pkg/app/releases/stable/#{version}/darwin/TRAE_CN-darwin-#{arch}.dmg"
  name "Trae CN"
  desc "AI IDE and work platform by ByteDance (Chinese version, Trae Work + Trae Code merged)"
  homepage "https://www.trae.cn"

  livecheck do
    url "https://api.trae.cn/icube/api/v1/native/version/trae/cn/latest"
    strategy :json do |json|
      json.dig("data", "manifest", "darwin", "download")
          &.find { |d| d["region"] == "cn" }&.dig("apple")
          &.[](%r{stable/(\d+(?:\.\d+)*)/}, 1)
    end
  end

  auto_updates true
  depends_on macos: :monterey

  app "Trae CN.app"

  zap trash: [
    "~/Library/Application Support/cn.trae.app",
    "~/Library/Caches/cn.trae.app",
    "~/Library/Preferences/cn.trae.app.plist",
    "~/Library/Saved Application State/cn.trae.app.savedState",
  ]
end

  deprecate! date: "2026-10-10", because: "moved to homebrew/cask", replacement_cask: "trae-cn"
  disable! date: "2027-10-10", because: "moved to homebrew/cask", replacement_cask: "trae-cn"
