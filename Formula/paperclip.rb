class Paperclip < Formula
  desc "面向零人类公司的开源 AI 智能体编排平台"
  homepage "https://paperclip.ing"
  url "https://registry.npmjs.org/paperclipai/-/paperclipai-2026.831.1.tgz"
  sha256 "4f14bac9b07eb184baaaa460b414dc63706f8f3964e42be7b22a78fb47f82b74"
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
