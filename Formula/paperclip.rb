class Paperclip < Formula
  desc "面向零人类公司的开源 AI 智能体编排平台"
  homepage "https://paperclip.ing"
  url "https://registry.npmjs.org/paperclipai/-/paperclipai-2026.1005.0.tgz"
  sha256 "60cf5e88a9ad0e68bf3a10e4ba6ba0df2f21560f81a73e6a25517fee82187d12"
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
