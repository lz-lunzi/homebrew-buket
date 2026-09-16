cask "quotio" do
  version "0.32.0"
  sha256 "30e1d7f9a99b01a91e2ec4506ed45c28a8f5a4b8d9cd17d102a9f117a135a92e"

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
