class Omp < Formula
  desc "AI coding agent for the terminal"
  homepage "https://omp.sh"
  license "MIT"
  version "18.1.13"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.1.13/omp-darwin-arm64"
      sha256 "a4c5c9cc5b8222184d0d7429b0bb6ac2a92bbe45dd11bf68e4b1360050791909"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.1.13/omp-darwin-x64"
      sha256 "224ee40faaff907359504749942d0df47860b96ba8098ca5127384554707f48a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.1.13/omp-linux-arm64"
      sha256 "06fc72183ca0c5b3add7d1dcc1a3005e17b9b67b679f04b5c646b08bfe763cb6"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.1.13/omp-linux-x64"
      sha256 "3be5a308cc91e6f6bba148175fbe651d3583ff6d32ae221cb931dc08a64e1f39"
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
