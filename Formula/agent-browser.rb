class AgentBrowser < Formula
  desc "AI 代理的无头浏览器自动化 CLI 工具"
  homepage "https://github.com/vercel-labs/agent-browser"

  deprecate! date: "2026-09-01", because: "moved to homebrew/core", replacement_formula: "agent-browser"
  disable! date: "2027-09-01", because: "moved to homebrew/core", replacement_formula: "agent-browser"

  url "https://registry.npmjs.org/agent-browser/-/agent-browser-0.38.1.tgz"
  sha256 "89a7df4761ff335e4dd5367e4cf04cecb9ba4e2cc130a0220f798d188414dc6c"
  license "Apache-2.0"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec.glob("bin/*")
  end

  test do
    system bin/"agent-browser", "--version"
  end
end
