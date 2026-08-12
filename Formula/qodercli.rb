class Qodercli < Formula
  desc "Qoder AI CLI - Terminal-based AI coding assistant"
  homepage "https://qoder.com"
  version "1.0.5"
  license "MIT"

  livecheck do
    skip "No public version API; OSS bucket listing denied"
  end

  on_macos do
    on_arm do
      url "https://qoder-ide.oss-accelerate.aliyuncs.com/qodercli/releases/1.0.5/qodercli-darwin-arm64.tar.gz"
      sha256 "e786a451169c83190813fb6b5680e2c481a4d7649459ca5944e5020853366c23"
    end
  end

  on_linux do
    on_intel do
      # Requires AVX2 support
      url "https://qoder-ide.oss-accelerate.aliyuncs.com/qodercli/releases/1.0.5/qodercli-linux-x64.tar.gz"
      sha256 "cc0eea07226db1b0b01083d88e6a73bfb7412e8c693947b940789d2da2888b5f"
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
