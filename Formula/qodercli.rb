class Qodercli < Formula
  desc "Qoder AI CLI - Terminal-based AI coding assistant"
  homepage "https://qoder.com"
  version "1.0.0"
  license "MIT"

  livecheck do
    url :stable
    regex(%r{releases/(\d+(?:\.\d+)+)/}i)
  end

  on_macos do
    on_intel do
      url "https://qoder-ide.oss-accelerate.aliyuncs.com/qodercli/releases/1.0.0/qodercli-darwin-x64.tar.gz"
      sha256 "ec913191247cb9ea6ba294d8fd7e815219345de92e08317db2206b1bc36fe5c2"
    end
    on_arm do
      url "https://qoder-ide.oss-accelerate.aliyuncs.com/qodercli/releases/1.0.0/qodercli-darwin-arm64.tar.gz"
      sha256 "9c073ad54df818541e7a8473070549dba4ebbe1a73dc799c6154e7f1cbe7e4df"
    end
  end

  on_linux do
    on_intel do
      # Default: requires AVX2 support
      url "https://qoder-ide.oss-accelerate.aliyuncs.com/qodercli/releases/1.0.0/qodercli-linux-x64.tar.gz"
      sha256 "cffcd3de6c0352004d2443d39aeb68b79d42ee8776b4b868c40dd473f05c213a"
    end
    on_arm do
      url "https://qoder-ide.oss-accelerate.aliyuncs.com/qodercli/releases/1.0.0/qodercli-linux-arm64.tar.gz"
      sha256 "4c1d66505a921a547f6e6f18152a6ee5a1aa1bc8631e0e4072088047f58e3682"
    end
  end

  def install
    bin.install "qodercli"
  end

  def caveats
    <<~EOS
      Qoder CLI - AI-powered coding assistant for terminal.

      Get started:
        qodercli --help

      Note for Linux x86_64 users:
        This build requires AVX2 CPU support. If your CPU lacks AVX2,
        use the baseline build instead:
          brew install qodercli-baseline

      Visit https://qoder.com for more information.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/qodercli --version")
  end
end
