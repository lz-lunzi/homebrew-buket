class NineRouter < Formula
  desc "Start and manage 9Router server"
  homepage "https://github.com/decolua/9router"
  url "https://registry.npmjs.org/9router/-/9router-0.5.95.tgz"
  sha256 "90d1a1f5830d9dd2a505779c22d6f6f5113d0e1da4877f4da0142060065f3c74"
  license "MIT"

  livecheck do
    url "https://registry.npmjs.org/9router/-/9router-0.5.91.tgz"
    regex(/"version"\s*:\s*"(\d+(?:\.\d+)+)"/i)
  end

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec.glob("bin/*")
  end

  def caveats
    <<~EOS
      9Router CLI - Start and manage 9Router server.

      Get started:
        9router --help

      Visit https://github.com/decolua/9router for more information.
    EOS
  end

  test do
    assert_match "9router", shell_output("#{bin}/9router --version")
  end
end
