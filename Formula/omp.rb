class Omp < Formula
  desc "AI coding agent for the terminal"
  homepage "https://omp.sh"
  license "MIT"
  version "18.1.19"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.1.19/omp-darwin-arm64"
      sha256 "defc1d398d6a90f34998d5120fb5b53cf7ae08c10dff91b834cab5a3b0461119"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.1.19/omp-darwin-x64"
      sha256 "133e4c11f0ba7f9a938d01bdb4fc0c9fff27f8913440e38d4d723cb5eb84a170"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.1.19/omp-linux-arm64"
      sha256 "b321b6bb2a96068df2f4972f98654c23e451371a275cfbb0a98ef6f5f858f239"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.1.19/omp-linux-x64"
      sha256 "4b5df0c61cc978223bd12f7e8d533554e80bb360a9192491de13da3d53b283ac"
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
