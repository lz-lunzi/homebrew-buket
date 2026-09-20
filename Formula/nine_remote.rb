class NineRemote < Formula
  desc "Terminal in Your Pocket - remote access tool for Mac, Linux, and Windows"
  homepage "https://github.com/decolua/9remote"
  url "https://registry.npmjs.org/9remote/-/9remote-3.0.3.tgz"
  sha256 "6ed1d18b1f33a401a08ce72ee2b11aadd9415d7b2e1e6b6cae5e2003c3a1d10d"
  license "MIT"

  livecheck do
    url "https://registry.npmjs.org/9remote/-/9remote-2.5.8.tgz"
    regex(/"version"\s*:\s*"(\d+(?:\.\d+)+)"/i)
  end

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec.glob("bin/*")
  end

  def caveats
    <<~EOS
      9Remote is a remote access tool - "Terminal in Your Pocket".

      Get started:
        9remote --help

      Visit https://github.com/decolua/9remote for more information.
    EOS
  end

  test do
    assert_match "9remote", shell_output("#{bin}/9remote --version")
  end
end
