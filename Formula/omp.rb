class Omp < Formula
  desc "AI coding agent for the terminal"
  homepage "https://omp.sh"
  license "MIT"
  version "18.8.7"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.8.7/omp-darwin-arm64"
      sha256 "cf0227bdefca0c486bd2aed1771de3ab98930266883eb69d341caf5665caee14"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.8.7/omp-darwin-x64"
      sha256 "8c78893d62f4a431006706697df132a0b54ce0ca45e4d61e8995a14c7ad53b05"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.8.7/omp-linux-arm64"
      sha256 "c8542530ed7cb54ce0edd6ac2cbbdab892e8b74cd740074686dc6d2c5786b0fc"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.8.7/omp-linux-x64"
      sha256 "b87f9835a0acdbb81bbbad8273aa2d999b608a208598421a9584cffeb3139a8a"
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
