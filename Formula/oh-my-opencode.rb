class OhMyOpencode < Formula
  desc "OpenCode 插件 - 自定义智能体（oracle、librarian）和增强功能。与 Sisyphus 结合的最好的智能体工具用于自主编程"
  homepage "https://github.com/code-yeongyu/oh-my-opencode"
  url "https://registry.npmjs.org/oh-my-opencode/-/oh-my-opencode-5.0.1.tgz"
  sha256 "80909d7bb30476f0a7debe1d971333d7f05b584655334c79fcbf42ae98b3592a"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec.glob("bin/*")
  end

  test do
    system bin/"opencode", "--version"
  end
end
