class Pm2 < Formula
  desc "Process manager for Node.js applications"
  homepage "https://pm2.keymetrics.io"
  url "https://registry.npmjs.org/pm2/-/pm2-7.0.3.tgz"
  sha256 "daf790481179dbc51d495a3faf3724b6ea3c4375ba7652b16e9275a8e143eefa"
  license "AGPL-3.0-or-later"

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
