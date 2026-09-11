class NineRouter < Formula
  desc "Start and manage 9Router server"
  homepage "https://github.com/decolua/9router"
  url "https://registry.npmjs.org/9router/-/9router-0.5.75.tgz"
  sha256 "f0913397dcffbca440056b28925ec58fb575f074813ae5e8032cbd23315b03d4"
  license "MIT"

  livecheck do
    url "https://registry.npmjs.org/9router/-/9router-0.5.55.tgz"
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
