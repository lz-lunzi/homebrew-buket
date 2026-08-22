class VibeKanban < Formula
  desc "无冲突地并行编排 AI 编程智能体，并通过 diff 工具进行代码审查"
  homepage "https://www.vibekanban.com/"
  url "https://registry.npmjs.org/vibe-kanban/-/vibe-kanban-0.1.44.tgz"
  sha256 "fe087944ac951efa21fd7bb826e45c5716a92a9f744c2741b7b9f3978881c313"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec.glob("bin/*")
  end

  test do
    system bin/"vibe-kanban", "--version"
  end
end
