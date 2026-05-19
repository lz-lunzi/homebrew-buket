class Omniroute < Formula
  desc "Free AI gateway: one endpoint, 160+ providers, RTK+Caveman compression"
  homepage "https://github.com/diegosouzapw/OmniRoute"
  url "https://registry.npmjs.org/omniroute/-/omniroute-3.7.9.tgz"
  version "3.7.9"
  sha256 "3ea879fe77aa10831682f6e58925e8c7bf62071747c29a1493d4825e4c36c0f7"
  license "MIT"

  livecheck do
    url "https://registry.npmjs.org/omniroute/latest"
    regex(/"version"\s*:\s*"(\d+(?:\.\d+)+)"/i)
  end

  depends_on "node"
  depends_on "pm2"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec.glob("bin/*")
  end

  def caveats
    <<~EOS
      OmniRoute - Free AI gateway with 160+ providers.

      ─────────────────────────────────────────────────────────────
      Quick Start
      ─────────────────────────────────────────────────────────────

      Start in foreground:
        export INITIAL_PASSWORD=123456
        omniroute --port 20129

      Start as background service (via pm2):
        export INITIAL_PASSWORD=123456
        pm2 start "omniroute --port 20129" --name omniroute

      Manage pm2 process:
        pm2 list                 List all processes
        pm2 logs omniroute       View logs
        pm2 stop omniroute       Stop
        pm2 restart omniroute    Restart
        pm2 delete omniroute     Remove

      Auto-start on login:
        pm2 startup
        pm2 save

      ─────────────────────────────────────────────────────────────
      Known Issue (v3.7.9)
      ─────────────────────────────────────────────────────────────
      If INITIAL_PASSWORD is not set, the onboarding wizard hangs
      with "Failed to fetch" due to Service Worker interception.

      Workaround: always set INITIAL_PASSWORD before first launch.

      Docs: https://github.com/diegosouzapw/OmniRoute
    EOS
  end

  test do
    assert_match "omniroute", shell_output("#{bin}/omniroute --version")
  end
end
