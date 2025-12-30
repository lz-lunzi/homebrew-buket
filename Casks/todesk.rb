cask "todesk" do
  version :latest
  sha256 :no_check

  url "https://www.todesk.com/download.html",
      verified: "www.todesk.com"
  name "ToDesk"
  desc "Secure and fast remote desktop software with high performance"
  homepage "https://www.todesk.com/"

  depends_on macos: ">= :big_sur"

  # ToDesk installer will be downloaded from official website
  # The website may require manual selection for macOS version
  app "ToDesk.app"

  caveats <<~EOS
    ToDesk features:
    - Remote desktop control with <3ms latency
    - 8K and 360FPS display support
    - High-speed file transfer with drag-and-drop
    - Cross-platform: Windows/Mac/Linux/Android/iOS
    - Security: privacy protection, two-factor authentication
    - Advanced features: multi-screen collaboration, game controller mapping

    For manual download if installation fails:
    1. Visit https://www.todesk.com/download.html
    2. Download the macOS version
    3. Drag ToDesk.app to /Applications
  EOS
end
