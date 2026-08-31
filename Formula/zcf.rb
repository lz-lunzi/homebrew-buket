class Zcf < Formula
  desc "Claude Code & Codex 的零配置代码流 - 一键设置，支持双语、智能智能体系统和个性化 AI 助手"
  homepage "https://github.com/UfoMiao/zcf"
  url "https://registry.npmjs.org/zcf/-/zcf-3.7.3.tgz"
  sha256 "cbadc3e97a4ba781911837c05ff62f4ce57842a6e5666b4abbc6a5f7cd93d232"
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
