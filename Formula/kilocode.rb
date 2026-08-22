class Kilocode < Formula
  desc "Kilo Code CLI - 终端 AI 编程助手"
  homepage "https://github.com/Kilo-Org/kilo"
  url "https://registry.npmjs.org/@kilocode/cli/-/cli-7.4.23.tgz"
  sha256 "7ada12bcc1082b66ce34880f2111989bf6ba6cb58325997f0d2e4339d29b9f9d"
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
