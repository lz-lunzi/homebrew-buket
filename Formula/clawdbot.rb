class Clawdbot < Formula
  desc "个人 AI 助手 - 任何操作系统，任何平台"
  homepage "https://github.com/clawdbot/clawdbot"
  url "https://registry.npmjs.org/clawdbot/-/clawdbot-2026.1.24-3.tgz"
  sha256 "a00acd33ac20787fbd342db2bc36db15b2483f88e1f8b159cf1bc37a6eb1a828"
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
