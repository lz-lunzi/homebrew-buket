class Bifrost < Formula
  desc "High-performance AI gateway CLI - connect to 12+ providers"
  homepage "https://github.com/maximhq/bifrost"
  url "https://registry.npmjs.org/@maximhq/bifrost/-/bifrost-1.6.2.tgz"
  version "1.6.2"
  sha256 "116fe10c07c53fcfbc2bfefad475b90ffeafe0a4da94213c391c1737f34bb328"
  license "Apache-2.0"

  livecheck do
    url "https://registry.npmjs.org/@maximhq/bifrost/latest"
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
