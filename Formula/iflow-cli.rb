class IflowCli < Formula
  desc "Terminal AI assistant for code analysis and programming tasks"
  homepage "https://platform.iflow.cn/cli"
  url "https://registry.npmjs.org/@iflow-ai/iflow-cli/-/iflow-cli-0.2.7.tgz"
  sha256 "4af8e5f5c65309b3cc9cb6a5051a10d684a05fc091804286c74a803017c16a46"
  license :cannot_represent

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec.glob("bin/*")
  end

  test do
    assert_match "iflow version", shell_output("#{bin}/iflow --version")
  end
end
