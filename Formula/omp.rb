class Omp < Formula
  desc "AI coding agent for the terminal"
  homepage "https://omp.sh"
  license "MIT"
  version "18.1.18"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.1.18/omp-darwin-arm64"
      sha256 "035a35dcb249edb939fa02b74fc7c0df9b2eb659079349fbffb188e1b558957a"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.1.18/omp-darwin-x64"
      sha256 "29fead1b667dc969b825c5aa4798aadb5b7ec9b2f15c3304b10196d7afa4171d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.1.18/omp-linux-arm64"
      sha256 "1ae8273c231ceb88cebc9971901cf7f5d97ed4149cdc740a814f629cd2b4dcb2"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.1.18/omp-linux-x64"
      sha256 "45421f9a5f112bc47cb9f77c4b4d7927631f8ff859624f821287ec854eb239fc"
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
