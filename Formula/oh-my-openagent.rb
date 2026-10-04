class OhMyOpenagent < Formula
  desc "AI Agent Harness with Multi-Model Orchestration and LSP/AST Tools"
  homepage "https://github.com/code-yeongyu/oh-my-openagent"
  url "https://registry.npmjs.org/oh-my-openagent/-/oh-my-openagent-5.1.17.tgz"
  sha256 "eb30bb07f34ac106fbc47802e2dc0fb6e08a0de96012f2b53159da32ec3ab525"
  license "SUL-1.0"

  livecheck do
    url "https://registry.npmjs.org/oh-my-openagent/-/oh-my-openagent-5.1.5.tgz"
    regex(/"version"\s*:\s*"(\d+(?:\.\d+)+)"/i)
  end

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec.glob("bin/*")
  end

  def caveats
    <<~EOS
      Oh-My-OpenAgent - AI Agent Harness for OpenCode.

      Get started:
        oh-my-openagent --help

      Visit https://github.com/code-yeongyu/oh-my-openagent for more information.
    EOS
  end

  test do
    assert_match "oh-my-openagent", shell_output("#{bin}/oh-my-openagent --version")
  end
end
