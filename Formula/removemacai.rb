class Removemacai < Formula
  desc "Debloat macOS: turn off Apple Intelligence, analytics, ads and pop-ups"
  homepage "https://github.com/omlahore/RemoveMacAI"
  url "https://github.com/omlahore/RemoveMacAI/releases/download/v1.0.2/removemacai-darwin-arm64.tar.gz"
  version "1.0.2"
  sha256 "1df44466cd804228fad6a44e4ec4c0e88d85ad69a448e18914e1c807c5058fd6"
  license "MIT"

  livecheck do
    url "https://github.com/omlahore/RemoveMacAI/releases"
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on :macos

  def install
    bin.install "removemacai"
    prefix.install "THIRD-PARTY-NOTICES.md"
  end

  test do
    system bin/"removemacai", "selftest"
  end
end
