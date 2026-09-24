class Paseocli < Formula
  desc "Orchestrate multiple coding agents from desktop and mobile"
  homepage "https://paseo.sh"
  url "https://registry.npmjs.org/@getpaseo/cli/-/cli-0.9.2.tgz"
  sha256 "e19f77c334b2eb00c7671897524d534dbda6b0908c8e81ac96357d8a0967799d"
  license "AGPL-3.0-or-later"

  livecheck do
    url "https://registry.npmjs.org/@getpaseo/cli/-/cli-0.5.1.tgz"
    regex(/"version"\s*:\s*"(\d+(?:\.\d+)+)"/i)
  end

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec.glob("bin/*")
  end

  def caveats
    <<~EOS
      Paseo - Orchestrate multiple coding agents from desktop and mobile.

      Start the server:
        paseo

      Run an agent:
        paseo run --provider claude/opus-4.6 "implement user authentication"

      List running agents:
        paseo ls

      Attach to an agent:
        paseo attach <agent-id>

      Send task to an agent:
        paseo send <agent-id> "also add tests"

      Docs: https://paseo.sh
    EOS
  end

  test do
    assert_match "paseo", shell_output("#{bin}/paseo --version")
  end
end
