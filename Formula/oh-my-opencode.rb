class OhMyOpencode < Formula
  desc "OpenCode 插件 - 自定义智能体（oracle、librarian）和增强功能。与 Sisyphus 结合的最好的智能体工具用于自主编程"
  homepage "https://github.com/code-yeongyu/oh-my-opencode"
  url "https://registry.npmjs.org/oh-my-opencode/-/oh-my-opencode-5.1.0.tgz"
  sha256 "ed999338934ae05aafd264228bc0af159bba1ac491c1d0f3f7db6debdd10b47c"
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
