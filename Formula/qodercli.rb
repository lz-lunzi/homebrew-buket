class Qodercli < Formula
  desc "Qoder CLI - Agentic coding platform for terminal-based development"
  homepage "https://qoder.com/cli"
  url "https://registry.npmjs.org/@qoder-ai/qodercli/-/qodercli-1.0.0.tgz"
  sha256 "1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef"
  license "Proprietary"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec.glob("bin/*")
  end

  test do
    assert_match "qodercli version", shell_output("#{bin}/qodercli --version")
  end
end
