class IflowCli < Formula
  desc "Terminal AI assistant for code analysis, programming tasks and development workflows"
  homepage "https://platform.iflow.cn/cli"
  url "https://registry.npmjs.org/@iflow-ai/iflow-cli/-/iflow-cli-0.5.13.tgz"
  sha256 "cb20836899728afec257396d1e5824643c43e2a7001a1c6e72b9db9b7998bb77"
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
