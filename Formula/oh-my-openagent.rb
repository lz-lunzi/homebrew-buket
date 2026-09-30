class OhMyOpenagent < Formula
  desc "AI Agent Harness with Multi-Model Orchestration and LSP/AST Tools"
  homepage "https://github.com/code-yeongyu/oh-my-openagent"
  url "https://registry.npmjs.org/oh-my-openagent/-/oh-my-openagent-5.1.4.tgz"
  sha256 "6ac8482b714378caa8ff09639b2c231950aafb03528c145880cb768c04dc2980"
  license "SUL-1.0"

  livecheck do
    url "https://registry.npmjs.org/oh-my-openagent/-/oh-my-openagent-4.19.4.tgz"
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
