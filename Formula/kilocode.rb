class Kilocode < Formula
  desc "Kilo Code CLI - 终端 AI 编程助手"
  homepage "https://github.com/Kilo-Org/kilo"
  url "https://registry.npmjs.org/@kilocode/cli/-/cli-7.5.15.tgz"
  sha256 "76f2e6f9dd588def94155730607af1b80667422b71c7a958aece12b19af81ed0"
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
