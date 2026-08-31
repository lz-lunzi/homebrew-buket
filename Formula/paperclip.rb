class Paperclip < Formula
  desc "面向零人类公司的开源 AI 智能体编排平台"
  homepage "https://paperclip.ing"
  url "https://registry.npmjs.org/paperclipai/-/paperclipai-2026.824.1.tgz"
  sha256 "b9f5d634e584c77607202d6644d53b9ad131a11811f01f1474f68b1e4da8d8cf"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec.glob("bin/*")
  end

  test do
    system bin/"paperclip", "--version"
  end
end
