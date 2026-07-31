class Paseo < Formula
  desc "Orchestrate multiple coding agents from desktop and mobile"
  homepage "https://paseo.sh"
  url "https://registry.npmjs.org/@getpaseo/cli/-/cli-0.2.5.tgz"
  version "0.2.5"
  sha256 "a5afabde237262b705b2921da7c23bab89a2f431ceda2472ee9cc19ca07ba54d"
  license "AGPL-3.0-or-later"

  livecheck do
    url "https://registry.npmjs.org/@getpaseo/cli/latest"
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
