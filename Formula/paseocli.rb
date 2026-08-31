class Paseocli < Formula
  desc "Orchestrate multiple coding agents from desktop and mobile"
  homepage "https://paseo.sh"
  url "https://registry.npmjs.org/@getpaseo/cli/-/cli-0.6.1.tgz"
  sha256 "0561419f340daf3e6d496bd5e6755532f671158634597f699a859d08a2066daa"
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
