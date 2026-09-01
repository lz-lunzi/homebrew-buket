class QwenCode < Formula
  desc "一个在您的终端中运行的开源 AI 智能体"
  homepage "https://github.com/QwenLM/qwen-code"

  deprecate! date: "2026-09-01", because: "moved to homebrew/core", replacement_formula: "qwen-code"
  disable! date: "2027-09-01", because: "moved to homebrew/core", replacement_formula: "qwen-code"

  url "https://registry.npmjs.org/@qwen-code/qwen-code/-/qwen-code-0.22.0.tgz"
  sha256 "c0ae0ad006c4dd8b69ebe1705d13bb57d37d1c808dcb891c5bfcde91e66670c2"
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
