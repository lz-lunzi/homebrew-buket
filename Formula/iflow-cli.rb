class IflowCli < Formula
  desc "Terminal AI assistant for code analysis, programming tasks and development workflows"
  homepage "https://platform.iflow.cn/cli"
  url "https://registry.npmjs.org/@iflow-ai/iflow-cli/-/iflow-cli-0.2.7.tgz"
  sha256 "4af8e5f5c65309b3cc9cb6a5051a10d684a05fc091804286c74a803017c16a46"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec.glob("bin/*")
  end

  def caveats
    <<~EOS
      iFlow CLI requires Node.js >= 20.
      
      For best performance on macOS/Linux, you can also install uv (optional):
        brew install uv
      
      Official installation method:
        curl -fsSL https://cloud.iflow.cn/install | bash
      
      Visit https://platform.iflow.cn/cli for more information.
    EOS
  end

  test do
    assert_match "iflow", shell_output("#{bin}/iflow --version")
  end
end
