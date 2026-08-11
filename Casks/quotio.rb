cask "quotio" do
  version "0.25.0"
  sha256 "8c4eea58e257e9caff6b4f68be1cf43ff1054ce9eb3529d4c7e42ab0e9acecd4"

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
