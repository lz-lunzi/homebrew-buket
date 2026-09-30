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
      url "https://github.com/PrimeIntellect-ai/prime-agent/releases/download/v0.9.8/prime-agent-0.9.8-darwin-arm64.tar.gz"
      sha256 "078c9abd519978ef27f6404367e37a2981267db47f1b95b60940ea7fe6ead8b9"
    end
    on_intel do
      url "https://github.com/PrimeIntellect-ai/prime-agent/releases/download/v0.9.8/prime-agent-0.9.8-darwin-x64.tar.gz"
      sha256 "0ddac4fa06eb47043f661bee8da8d16d9a7d740a09adb8269d12bf3a76ded87a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/PrimeIntellect-ai/prime-agent/releases/download/v0.9.8/prime-agent-0.9.8-linux-arm64.tar.gz"
      sha256 "88a98ceff22d56f9a28ad8c41f38857f6586165f06761641f2190b0d5f8e4626"
    end
    on_intel do
      url "https://github.com/PrimeIntellect-ai/prime-agent/releases/download/v0.9.8/prime-agent-0.9.8-linux-x64.tar.gz"
      sha256 "83fb09129bf78e3e60268212cd70932166591b15188caa70c1b0efbcc76235e2"
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
