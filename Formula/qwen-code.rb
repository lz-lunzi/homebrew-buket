class QwenCode < Formula
  desc "一个在您的终端中运行的开源 AI 智能体"
  homepage "https://github.com/QwenLM/qwen-code"

  deprecate! date: "2026-09-01", because: "moved to homebrew/core", replacement_formula: "qwen-code"
  disable! date: "2027-09-01", because: "moved to homebrew/core", replacement_formula: "qwen-code"

  url "https://registry.npmjs.org/@qwen-code/qwen-code/-/qwen-code-0.24.7.tgz"
  sha256 "64430248ab6e996fc0c6b9a0789361f868c3b97f83d16210e0424e51dffc5fa9"
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
