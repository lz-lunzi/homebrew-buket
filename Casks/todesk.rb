cask "todesk" do
  version :latest
  sha256 :no_check

  url "https://dl.todesk.com/macos/ToDesk_latest.pkg",
      verified: "dl.todesk.com"
  name "ToDesk"
  desc "Secure and fast remote desktop software with high performance"
  homepage "https://www.todesk.com/"

  depends_on macos: ">= :big_sur"

  installer script: {
    executable: "/usr/sbin/installer",
    args: ["-pkg", "#{staged_path}/ToDesk_latest.pkg", "-target", "/"],
    sudo: true,
  }

  uninstall delete: [
    "/Applications/ToDesk.app",
  ],
             quit: "ToDesk"

  caveats <<~EOS
    NOTE: ToDesk installer is dynamically generated and may change checksums.
    SHA256 verification has been disabled.

    ToDesk features:
    - Remote desktop control with <3ms latency
    - 8K and 360FPS display support
    - High-speed file transfer with drag-and-drop
    - Cross-platform: Windows/Mac/Linux/Android/iOS
    - Security: privacy protection, two-factor authentication
    - Advanced features: multi-screen collaboration, game controller mapping

    Enterprise version available: https://enterprise.todesk.com
  EOS
end
