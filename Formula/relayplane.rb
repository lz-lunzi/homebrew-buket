class Relayplane < Formula
  desc "Cost intelligence proxy for AI agents with smart model routing"
  homepage "https://relayplane.com"
  url "https://registry.npmjs.org/@relayplane/proxy/-/proxy-1.9.40.tgz"
  sha256 "a3de60a3dc0b6ad4a7015c76003186d4018fbb91c63a74079bbcf8699e37185f"
  license "MIT"

  livecheck do
    url "https://registry.npmjs.org/@relayplane/proxy/latest"
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
