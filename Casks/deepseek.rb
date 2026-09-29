cask "deepseek" do
  version "0.2.0-rc.2"
  sha256 :no_check

  url "https://download.deepseek.com/desktop/dsh-latest-macos-arm64.dmg"
  name "DeepSeek Harness"
  desc "Desktop client for the DeepSeek AI assistant"
  homepage "https://www.deepseek.com/"

  livecheck do
    skip "No public version API; download URL serves an unversioned latest artifact"
  end

  depends_on macos: :ventura

  app "DeepSeek Harness.app"

  zap trash: [
    "~/Library/Application Support/DeepSeek Harness",
    "~/Library/Caches/com.deepseek.dsh",
    "~/Library/Preferences/com.deepseek.dsh.plist",
    "~/Library/Saved Application State/com.deepseek.dsh.savedState",
  ]
end
