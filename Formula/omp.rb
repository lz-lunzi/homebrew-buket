class Omp < Formula
  desc "AI coding agent for the terminal"
  homepage "https://omp.sh"
  license "MIT"
  version "18.1.14"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.1.14/omp-darwin-arm64"
      sha256 "66c09cc5ffc8e080335649579c7cc32212d7e2a13d486a14f45d00f3088ea6d2"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.1.14/omp-darwin-x64"
      sha256 "bf5653dfc74bc9aa6edd6967323cabf0cfb76ade80f669ae2e554f27fa2dad0e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.1.14/omp-linux-arm64"
      sha256 "93ba1143e95c6a138ecfaea5efa6057e45aa6e40853d88a55b48586d118f7325"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.1.14/omp-linux-x64"
      sha256 "27dd66cb6a2c39fff51e1fe6db40f1f376fee4a3d04457f236edaa5d0290e4d2"
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
