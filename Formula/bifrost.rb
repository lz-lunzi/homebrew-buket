class Bifrost < Formula
  desc "High-performance AI gateway CLI - connect to 12+ providers"
  homepage "https://github.com/maximhq/bifrost"
  url "https://registry.npmjs.org/@maximhq/bifrost/-/bifrost-1.6.3.tgz"
  sha256 "b1f95e5c95af44f9b424f4f6e5ea194ff7965351f6e9a9ab70ce4eaa3714c0e6"
  license "Apache-2.0"

  livecheck do
    url "https://registry.npmjs.org/@maximhq/bifrost/-/bifrost-1.6.3.tgz"
    regex(/"version"\s*:\s*"(\d+(?:\.\d+)+)"/i)
  end

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec.glob("bin/*")
  end

  def caveats
    <<~EOS
      Bifrost - High-performance AI gateway CLI.

      Get started:
        bifrost --help

      Visit https://github.com/maximhq/bifrost for more information.
    EOS
  end

  test do
    assert_match "bifrost", shell_output("#{bin}/bifrost --version")
  end
end
