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
      url "https://github.com/PrimeIntellect-ai/prime-agent/releases/download/v0.9.6/prime-agent-0.9.6-darwin-arm64.tar.gz"
      sha256 "97aff54310fde0c7a1d2a596a362db526f553395348a81696ec12c7c339052e1"
    end
    on_intel do
      url "https://github.com/PrimeIntellect-ai/prime-agent/releases/download/v0.9.6/prime-agent-0.9.6-darwin-x64.tar.gz"
      sha256 "06cd18ed7f9b898b38a416b6fac9df17d3c6b00e2a6f08546a39f57ae14076b7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/PrimeIntellect-ai/prime-agent/releases/download/v0.9.6/prime-agent-0.9.6-linux-arm64.tar.gz"
      sha256 "471574022a8b8eacca5a434d1c9c624c4ace405a328cd0e03572e4041b194f5c"
    end
    on_intel do
      url "https://github.com/PrimeIntellect-ai/prime-agent/releases/download/v0.9.6/prime-agent-0.9.6-linux-x64.tar.gz"
      sha256 "2ea7812a310bc16ae0c99fff7bca1d1e465077af38cf103aad167f10c2129801"
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
