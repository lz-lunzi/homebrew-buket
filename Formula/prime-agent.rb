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
      url "https://github.com/PrimeIntellect-ai/prime-agent/releases/download/v0.10.0/prime-agent-0.10.0-darwin-arm64.tar.gz"
      sha256 "e418bdf62fcb0002777bf3ac43bcc136512b26763f2ab5c500792f26e37294e5"
    end
    on_intel do
      url "https://github.com/PrimeIntellect-ai/prime-agent/releases/download/v0.10.0/prime-agent-0.10.0-darwin-x64.tar.gz"
      sha256 "af4866b5ba82f3419b964290e3f023ddb9b99958a89e16ee856962b901ec0fc6"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/PrimeIntellect-ai/prime-agent/releases/download/v0.10.0/prime-agent-0.10.0-linux-arm64.tar.gz"
      sha256 "f3cab3530a4d7ca43dbef8321bf13f260d1ba05d8b5dde057165a20bd4f675c4"
    end
    on_intel do
      url "https://github.com/PrimeIntellect-ai/prime-agent/releases/download/v0.10.0/prime-agent-0.10.0-linux-x64.tar.gz"
      sha256 "c16bd2af5e77b53f49b914a44742c4cf6a67c5ed5000041430b78dbd4c3bcbec"
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
