class Kilocode < Formula
  desc "Kilo Code CLI - 终端 AI 编程助手"
  homepage "https://github.com/Kilo-Org/kilo"
  url "https://registry.npmjs.org/@kilocode/cli/-/cli-7.7.2.tgz"
  sha256 "4c57f974b197833f39c3693caca495f6170535f7d6d30df76f6eeeaa94510608"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec.glob("bin/*")
  end

  test do
    system bin/"kilo", "--version"
  end
end
