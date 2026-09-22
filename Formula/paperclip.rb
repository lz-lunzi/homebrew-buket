class Paperclip < Formula
  desc "面向零人类公司的开源 AI 智能体编排平台"
  homepage "https://paperclip.ing"
  url "https://registry.npmjs.org/paperclipai/-/paperclipai-2026.916.1.tgz"
  sha256 "e7b14d6abb17cdb994ab587ae72788c29789d95c7add811e5d58106170c9a9b9"
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
