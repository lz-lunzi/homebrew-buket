cask "v2rayn" do
  version "7.19.5"
  sha256 :no_check

  on_arm do
    url "https://github.com/2dust/v2rayN/releases/download/#{version}/v2rayN-macos-arm64.dmg"
  end
  on_intel do
    url "https://github.com/2dust/v2rayN/releases/download/#{version}/v2rayN-macos-64.dmg"
  end

  name "v2rayN"
  desc "GUI client supporting Xray and sing-box cores"
  homepage "https://github.com/2dust/v2rayN"

  livecheck do
    url "https://github.com/2dust/v2rayN/releases"
    strategy :github_latest
  end

  depends_on macos: ">= :big_sur"

  app "v2rayN.app"

  caveats <<~EOS
    v2rayN is a multi-platform proxy client with GUI.

    Features:
    - Support Xray core and sing-box core
    - Built-in GeoIP and GeoSite rules
    - Support multiple protocols: VMess, VLESS, Trojan, Shadowsocks, etc.
    - User-friendly GUI interface

    Note: The dmg package is not signed. If macOS shows "app is damaged",
    run the following command:

      xattr -cr /Applications/v2rayN.app
  EOS
end
