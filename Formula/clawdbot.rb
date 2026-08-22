class Clawdbot < Formula
  desc "个人 AI 助手 - 任何操作系统，任何平台"
  homepage "https://github.com/clawdbot/clawdbot"
  url "https://registry.npmjs.org/clawdbot/-/clawdbot-2026.1.24-3.tgz"
  sha256 "0c34020e49a3df4d00053198393d769002c0cef45bc8a773ddbbcb478c923add"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec.glob("bin/*")
  end

  test do
    system bin/"clawdbot", "--version"
  end
end
