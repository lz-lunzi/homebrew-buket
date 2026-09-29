class PrimeAgent < Formula
  desc "Self-improving RLM agent for coding workflows and long-running autonomous tasks"
  homepage "https://github.com/PrimeIntellect-ai/prime-agent"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  # 自包含二进制（Bun 编译，内置 Python runtime），无需 node。
  # linux-x64 有 baseline 变体；formula 取标准版。
  on_macos do
    on_arm do
      url "https://github.com/PrimeIntellect-ai/prime-agent/releases/download/v0.9.7/prime-agent-0.9.7-darwin-arm64.tar.gz"
      sha256 "c28db14d0cfd53375d1a5007d8edad521199ba289e7b6332e9886604a0a3c22b"
    end
    on_intel do
      url "https://github.com/PrimeIntellect-ai/prime-agent/releases/download/v0.9.7/prime-agent-0.9.7-darwin-x64.tar.gz"
      sha256 "7f11a168e51f8bedfde38c753e29abe89919678c3d9538637c9d5af5d0fa1501"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/PrimeIntellect-ai/prime-agent/releases/download/v0.9.7/prime-agent-0.9.7-linux-arm64.tar.gz"
      sha256 "69383194c9edec4d54b82055da698d05281cec219200e6ff1341cf5445d177de"
    end
    on_intel do
      url "https://github.com/PrimeIntellect-ai/prime-agent/releases/download/v0.9.7/prime-agent-0.9.7-linux-x64.tar.gz"
      sha256 "47981c19396bcaabfabc4d6d788e64d55c057288d8676fc5733ab525803be066"
    end
  end

  def install
    # tarball 内含 runtime/skills/docs 等资源目录，二进制相对自身路径解析，
    # 整体装进 libexec，bin 只放入口 symlink。
    libexec.install Dir["*"]
    bin.install_symlink libexec/"prime-agent"
  end

  def caveats
    <<~EOS
      Prime Agent — self-improving RLM agent.

      快速开始:
        prime-agent --help

      首次启动后运行 /login 选择订阅或 API-key provider。

      文档: https://github.com/PrimeIntellect-ai/prime-agent/blob/main/packages/coding-agent/docs/quickstart.md
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/prime-agent --version")
  end
end
