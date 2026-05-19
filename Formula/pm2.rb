class Pm2 < Formula
  desc "Process manager for Node.js applications"
  homepage "https://pm2.keymetrics.io"
  url "https://registry.npmjs.org/pm2/-/pm2-7.0.1.tgz"
  version "7.0.1"
  sha256 "e668a26657a9a95ee0d903c6acfaf62995b5a219ac3a673773eded08b4465e5b"
  license "AGPL-3.0"

  livecheck do
    url "https://registry.npmjs.org/pm2/latest"
    regex(/"version"\s*:\s*"(\d+(?:\.\d+)+)"/i)
  end

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec.glob("bin/*")
  end

  def caveats
    <<~EOS
      PM2 - Production process manager for Node.js.

      Common commands:
        pm2 start app.js       Start an app
        pm2 list               List all apps
        pm2 stop <id|name>     Stop an app
        pm2 restart <id|name>  Restart an app
        pm2 delete <id|name>   Delete an app
        pm2 logs               Show logs
        pm2 monit              Monitor apps

      Startup script (persist across reboots):
        pm2 startup
        pm2 save

      Docs: https://pm2.keymetrics.io/docs/usage/quick-start/
    EOS
  end

  test do
    assert_match "pm2", shell_output("#{bin}/pm2 --version")
  end
end
