class Omp < Formula
  desc "AI coding agent for the terminal"
  homepage "https://omp.sh"
  license "MIT"
  version "18.3.1"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.3.1/omp-darwin-arm64"
      sha256 "67b807a99454a4d8e1cf982dce7b3343b2c2fc148f33e403dbfb3f1049b22570"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.3.1/omp-darwin-x64"
      sha256 "f7ee52cc4d97c0c3af4b271dff940e2be31fe1e22d4fd125eda6e0c1bb97d5b0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.3.1/omp-linux-arm64"
      sha256 "95b9e3dc3c2096885be2c9c923bd45bb3bf81d172367db7e7090936729261e2c"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.3.1/omp-linux-x64"
      sha256 "0806df602bf2bb9b202d152204b1bef6450eb6bcbfbf31d66e3767d1bbb3b3a7"
    end
  end

  def install
    bin.install Dir.glob("omp-*").first => "omp"
  end

  def caveats
    <<~EOS
      Omp — AI coding agent for the terminal.

      Get started:
        omp --help

      Configure your provider:
        omp /login

      Visit https://omp.sh for documentation.
    EOS
  end

  test do
    assert_match "omp", shell_output("#{bin}/omp --version")
  end
end
