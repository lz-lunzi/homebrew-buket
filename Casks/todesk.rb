cask "todesk" do
  version "4.8.2.3"
  sha256 "688f5d20308e22c4acc721253e52ec6b61bebf686bc26e86c6999a960c6d9781"

  url "https://dl.todesk.com/macos/ToDesk_#{version}.pkg",
      verified: "dl.todesk.com"
  name "ToDesk"
  desc "Secure and fast remote desktop software with high performance"
  homepage "https://www.todesk.com/"

  depends_on macos: ">= :big_sur"

  pkg "ToDesk_#{version}.pkg"

  caveats <<~EOS
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
