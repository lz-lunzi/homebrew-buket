cask "todesk" do
  version "4.8.5.1"
  sha256 :no_check

  url "https://dl.todesk.com/macos/ToDesk_#{version}.pkg",
      verified: "dl.todesk.com"
  name "ToDesk"
  desc "Secure and fast remote desktop software with high performance"
  homepage "https://www.todesk.com/"

  livecheck do
    url "https://www.todesk.com/download/"
    regex(/href=.*?ToDesk[._-]v?(\d+(?:\.\d+)+)\.pkg/i)
  end

  depends_on macos: ">= :big_sur"

  pkg "ToDesk_#{version}.pkg"

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
