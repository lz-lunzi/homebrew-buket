class PiCodingAgent < Formula
  desc "AI 编码智能体 CLI，提供 read、bash、edit、write 工具和会话管理"
  homepage "https://github.com/badlogic/pi-mono"

  deprecate! date: "2026-09-01", because: "moved to homebrew/core", replacement_formula: "pi-coding-agent"
  disable! date: "2027-09-01", because: "moved to homebrew/core", replacement_formula: "pi-coding-agent"

  url "https://registry.npmjs.org/@mariozechner/pi-coding-agent/-/pi-coding-agent-0.73.1.tgz"
  sha256 "7bf5d492670c04fd7c599dee7e6eaabff964084affd216766107e6741df7a2e1"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec.glob("bin/*")
  end

  test do
    system bin/"pi-coding-agent", "--version"
  end
end
