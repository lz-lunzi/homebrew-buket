class Zcf < Formula
  desc "Claude Code & Codex 的零配置代码流 - 一键设置，支持双语、智能智能体系统和个性化 AI 助手"
  homepage "https://github.com/UfoMiao/zcf"
  url "https://registry.npmjs.org/zcf/-/zcf-3.7.2.tgz"
  sha256 "48a7234ed7e40a06e508d5c5aa439b67965beb04cb78cc47f17af56ead985360"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec.glob("bin/*")
  end

  test do
    system bin/"zcf", "--version"
  end
end
