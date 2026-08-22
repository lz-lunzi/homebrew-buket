class AddSkill < Formula
  desc "为 AI 编码代理安装技能包（OpenCode, Claude Code, Codex, Cursor 等）"
  homepage "https://github.com/vercel-labs/add-skill"
  url "https://registry.npmjs.org/add-skill/-/add-skill-2.0.0.tgz"
  sha256 "3f63cf90141c5908d20c275f8d16dca6aebb0ad6c2972ba07c637fd93f21be32"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec.glob("bin/*")
  end

  test do
    system bin/"add-skill", "--version"
  end
end
