cask "quotio" do
  version "0.30.0"
  sha256 "e8dd29b15b73aa22e4575057092dd83543d90382622095f8f1235cdca1b9af7f"

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
