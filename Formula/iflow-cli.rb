class IflowCli < Formula
  desc "Terminal AI assistant for code analysis and programming tasks"
  homepage "https://platform.iflow.cn/cli"
  url "https://registry.npmjs.org/@iflow-ai/iflow-cli/-/iflow-cli-0.2.7.tgz"
  sha256 "e8c56c508699e9406580c584658a965634f06c6c9c9347f945f356830873d7c66"
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
