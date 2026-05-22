class Qodercli < Formula
  desc "Qoder AI CLI - Terminal-based AI coding assistant"
  homepage "https://qoder.com"
  version "1.0.2"
  license "MIT"

  livecheck do
    url :stable
    regex(%r{releases/(\d+(?:\.\d+)+)/}i)
  end

  on_macos do
    on_intel do
      url "https://qoder-ide.oss-accelerate.aliyuncs.com/qodercli/releases/1.0.2/qodercli-darwin-x64.tar.gz"
      sha256 "510f2b4c94c84117003296d9debb3d18bbe1ab43d292c5ce7af393d37ddee746"
    end
    on_arm do
      url "https://qoder-ide.oss-accelerate.aliyuncs.com/qodercli/releases/1.0.2/qodercli-darwin-arm64.tar.gz"
      sha256 "ff2822a177df923cd0cd443dfc9fed7c2a219c04c31921c7b3436d8d7d975a1e"
    end
  end

  on_linux do
    on_intel do
      # Default: requires AVX2 support
      url "https://qoder-ide.oss-accelerate.aliyuncs.com/qodercli/releases/1.0.2/qodercli-linux-x64.tar.gz"
      sha256 "5ab5024e1f5ccf8d418a118c4050aaf1b0261fe5e67b47df3d29253db54f2700"
    end
    on_arm do
      url "https://qoder-ide.oss-accelerate.aliyuncs.com/qodercli/releases/1.0.2/qodercli-linux-arm64.tar.gz"
      sha256 "dfa5b1551c3166985f7fc8e1af450ded5b24c895f624e00b9309ada6ef4ec277"
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
