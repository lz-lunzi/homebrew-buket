class OhMyOpenagent < Formula
  desc "AI Agent Harness with Multi-Model Orchestration and LSP/AST Tools"
  homepage "https://github.com/code-yeongyu/oh-my-openagent"
  url "https://registry.npmjs.org/oh-my-openagent/-/oh-my-openagent-5.1.19.tgz"
  sha256 "415f3b0697b54c653e4b601627337ae0146b5f63eef642a9b99e27a8c8b9e46b"
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
