class Kilocode < Formula
  desc "Kilo Code CLI - 终端 AI 编程助手"
  homepage "https://github.com/Kilo-Org/kilo"
  url "https://registry.npmjs.org/@kilocode/cli/-/cli-7.6.2.tgz"
  sha256 "e5acf0f82db1912e35d972a7de5e679a467498e128c872e9a3df9d96c61b18ef"
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
