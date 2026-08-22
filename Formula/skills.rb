class Skills < Formula
  desc "Vercel Skills CLI - 开放代理技能工具，支持 OpenCode、Claude Code、Codex、Cursor 等 35+ 平台"
  homepage "https://github.com/vercel-labs/skills"
  url "https://registry.npmjs.org/skills/-/skills-1.5.23.tgz"
  sha256 "a4ddbadeedfd7aee5e1823c2037b0a313ce4017a8ff1f23b9f7fe30d52a1c963"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec.glob("bin/*")
  end

  test do
    system bin/"skills", "--version"
  end
end
