class Omp < Formula
  desc "AI coding agent for the terminal"
  homepage "https://omp.sh"
  license "MIT"
  version "17.2.12"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v17.2.12/omp-darwin-arm64"
      sha256 "ab4ff24c8ba3ae6fd9d4b54969c94f4408cc316675f5534729ae502d8c97df74"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v17.2.12/omp-darwin-x64"
      sha256 "ede51625873bb7e59200711ebe44b775919a18b46fe927995a41f9315a9c96aa"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v17.2.12/omp-linux-arm64"
      sha256 "f176edf8174db252abe1aa6e84df284e1b83b8dd7ef34ac7faf7884a5e172a4c"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v17.2.12/omp-linux-x64"
      sha256 "6c75331bf09d5a9e9433bd592b3ee993d751a15d5b7450c1a334cc0684996f30"
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
