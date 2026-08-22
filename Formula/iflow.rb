class Iflow < Formula
  desc "一个终端 AI 助手，可以分析代码、执行编程任务和处理文件操作。"
  homepage "https://platform.iflow.cn/cli/quickstart"
  url "https://registry.npmjs.org/@iflow-ai/iflow-cli/-/iflow-cli-0.5.19.tgz"
  sha256 "51ed6292021acff61335baa961dbbca958e872b4f9f8b795bea79ee2dc07d5b8"
  license "Proprietary"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec.glob("bin/*")
  end

  test do
    system bin/"iflow", "--version"
  end
end
