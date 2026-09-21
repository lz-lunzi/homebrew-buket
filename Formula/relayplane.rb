class Relayplane < Formula
  desc "Cost intelligence proxy for AI agents with smart model routing"
  homepage "https://relayplane.com"
  url "https://registry.npmjs.org/@relayplane/proxy/-/proxy-1.9.63.tgz"
  sha256 "db1bb48ac6c832b23dc47441cd65c2c7d60158d1fb6dff1572411556581f97c8"
  license "MIT"

  livecheck do
    url "https://registry.npmjs.org/@relayplane/proxy/-/proxy-1.9.46.tgz"
    regex(/"version"\s*:\s*"(\d+(?:\.\d+)+)"/i)
  end

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec.glob("bin/*")
  end

  def caveats
    <<~EOS
      RelayPlane - Cost intelligence proxy for AI agents.

      Get started:
        relayplane start

      Set environment for Claude Code:
        export ANTHROPIC_BASE_URL=http://localhost:4100

      View stats:
        relayplane stats

      Dashboard: http://localhost:4100
      Docs: https://relayplane.com/docs/quickstart
    EOS
  end

  test do
    assert_match "relayplane", shell_output("#{bin}/relayplane --version")
  end
end
