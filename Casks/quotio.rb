cask "quotio" do
  version "0.27.0"
  sha256 "0b7b571230a805f71d2a9cd5b28cc9658edb316512bde83a5417b8ddfa4b4187"

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
