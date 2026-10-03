class OhMyOpencode < Formula
  desc "OpenCode 插件 - 自定义智能体（oracle、librarian）和增强功能。与 Sisyphus 结合的最好的智能体工具用于自主编程"
  homepage "https://github.com/code-yeongyu/oh-my-opencode"
  url "https://registry.npmjs.org/oh-my-opencode/-/oh-my-opencode-5.1.13.tgz"
  sha256 "fcc9e2308a89b429b28193b417105090702f8227ddcd09f23152c9fa78a21989"
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
