class Pm2 < Formula
  desc "Process manager for Node.js applications"
  homepage "https://pm2.keymetrics.io"
  url "https://registry.npmjs.org/pm2/-/pm2-7.0.4.tgz"
  sha256 "5efd8e2c586d7fc1e878d4d0742e2c0aae76c68814308c4b9c08cab25ef24894"
  license "AGPL-3.0-or-later"

  livecheck do
    url "https://registry.npmjs.org/pm2/-/pm2-7.0.3.tgz"
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
