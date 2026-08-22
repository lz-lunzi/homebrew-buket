class QwenCode < Formula
  desc "一个在您的终端中运行的开源 AI 智能体"
  homepage "https://github.com/QwenLM/qwen-code"
  url "https://registry.npmjs.org/@qwen-code/qwen-code/-/qwen-code-0.21.15.tgz"
  sha256 "8d405b065888b7000a6989d99c2d79257cd8f9f5b68e9078fb76484527351b9a"
  license "Apache-2.0"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec.glob("bin/*")
  end

  test do
    system bin/"qwen-code", "--version"
  end
end
