cask "quotio" do
  version "0.3.0"
  sha256 "4c0e4e4a4e4a4e4a4e4a4e4a4e4a4e4a4e4e4a4e4e4a4e4e4a4e4e4a4e4a4e4a" # placeholder, needs actual SHA256

  url "https://github.com/nguyenphutrong/quotio/releases/download/v#{version}/Quotio-#{version}.dmg"
  name "Quotio"
  desc "AI coding assistants manager with multi-provider support and quota tracking"
  homepage "https://github.com/nguyenphutrong/quotio"
  license "MIT"

  app "Quotio.app"

  caveats <<~EOS
    The app is not signed with an Apple Developer certificate yet.
    If macOS blocks the app, run:

      xattr -cr /Applications/Quotio.app
  EOS
end
