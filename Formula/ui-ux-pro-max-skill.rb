class UiUxProMaxSkill < Formula
  desc "用于为 AI 编程助手安装 UI/UX Pro Max 技能的 CLI。提供设计智能，用于跨多个平台和框架构建专业的 UI/UX"
  homepage "https://github.com/nextlevelbuilder/ui-ux-pro-max-skill"
  url "https://registry.npmjs.org/uipro-cli/-/uipro-cli-2.2.3.tgz"
  sha256 "4e69eec78aeafb96e02fb253a0c5524d69667e2c542fe37957ed010ebb66c5d5"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec.glob("bin/*")
  end

  test do
    system bin/"uipro", "--version"
  end
end
