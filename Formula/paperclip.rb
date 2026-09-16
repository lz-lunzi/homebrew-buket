class Paperclip < Formula
  desc "面向零人类公司的开源 AI 智能体编排平台"
  homepage "https://paperclip.ing"
  url "https://registry.npmjs.org/paperclipai/-/paperclipai-2026.916.0.tgz"
  sha256 "2f5b2d1361f69a97b86adb8b88c2b1f35118e7f9f3718369609e712a17468e0c"
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
