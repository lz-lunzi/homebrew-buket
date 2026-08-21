cask "quotio" do
  version "0.28.0"
  sha256 "abb790eae5c5b6c0b51ffa35ab17f77e34bbdfaa134d0fb2bd8d295a12ca3e93"

  url "https://github.com/nguyenphutrong/quotio/releases/download/v#{version}/Quotio-#{version}.dmg"
  name "Quotio"
  desc "AI coding assistants manager with multi-provider support and quota tracking"
  homepage "https://github.com/nguyenphutrong/quotio"

  livecheck do
    url "https://github.com/nguyenphutrong/quotio/releases"
    strategy :github_latest
  end

  depends_on :macos

  app "Quotio.app"

  caveats <<~EOS
    The app is not signed with an Apple Developer certificate yet.
    If macOS blocks the app, run:

      xattr -cr /Applications/Quotio.app
  EOS
end
