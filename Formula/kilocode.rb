class Kilocode < Formula
  desc "Kilo Code CLI - 终端 AI 编程助手"
  homepage "https://github.com/Kilo-Org/kilo"
  url "https://registry.npmjs.org/@kilocode/cli/-/cli-7.7.1.tgz"
  sha256 "eca1a24691f680b7215703eca1355a642a30acef076402ab65b4a54756564325"
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
