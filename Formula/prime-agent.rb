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
      url "https://github.com/PrimeIntellect-ai/prime-agent/releases/download/v0.9.5/prime-agent-0.9.5-darwin-arm64.tar.gz"
      sha256 "fc74d38ac4450a495678333e63a88b2a726c3ad5a30c2e45b122c8095729e5f6"
    end
    on_intel do
      url "https://github.com/PrimeIntellect-ai/prime-agent/releases/download/v0.9.5/prime-agent-0.9.5-darwin-x64.tar.gz"
      sha256 "0271a6de21343d2ffedffd4a015631e9b4e1162d79b8264780a57c561c31b117"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/PrimeIntellect-ai/prime-agent/releases/download/v0.9.5/prime-agent-0.9.5-linux-arm64.tar.gz"
      sha256 "81303f98f31aed99aa641a66ccb87629940de1e45dd86d56ede1d88fd521971c"
    end
    on_intel do
      url "https://github.com/PrimeIntellect-ai/prime-agent/releases/download/v0.9.5/prime-agent-0.9.5-linux-x64.tar.gz"
      sha256 "bc4b0ed791d1e8b3b5d6a95249a60306d9579fc0d6038e5d7d82f068d81f008d"
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
