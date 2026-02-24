class QoderCli < Formula
  desc "Agentic AI coding platform for terminal-based development"
  homepage "https://qoder.com"
  url "https://registry.npmjs.org/@qoder-ai/qodercli/-/qodercli-0.1.29.tgz"
  sha256 "a1b2c3d4e5f6g7h8i9j0k1l2m3n4o5p6q7r8s9t0u1v2w3x4y5z6a7b8c9d0e1f2"
  license "MIT"
  version "0.1.29"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec.glob("bin/*")
  end

  def caveats
    <<~EOS
      Qoder CLI is an agentic AI coding platform that provides:
      - Nextnew: Predictive code completion with Tab
      - Agentic Chat: Collaborative AI planning and coding
      - Autonomous Agents: End-to-end task automation
      - Repo Wiki: Automated codebase documentation
      - MCP Support: Extensible capabilities via MCP tools

      Alternative installation methods:
        curl -fsSL https://qoder.com/install | bash
        brew install --cask qodercli

      Visit https://qoder.com for more information.
    EOS
  end

  test do
    assert_match "qodercli", shell_output("#{bin}/qodercli --version")
  end
end
