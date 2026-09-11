class Omp < Formula
  desc "AI coding agent for the terminal"
  homepage "https://omp.sh"
  license "MIT"
  version "18.1.17"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.1.17/omp-darwin-arm64"
      sha256 "1c310974d4be8de4e5b7285e9c52647321b412c219790fe0243cf804d5c9d5cc"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.1.17/omp-darwin-x64"
      sha256 "6299ea1c91ebe80de07b98280bb45c7b8df7892a20ecf4f819cf660ca7e7cee0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.1.17/omp-linux-arm64"
      sha256 "58ab1b8f75d202cf3767e19901c834d2435898a189d5993be6d5cae6736716e1"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.1.17/omp-linux-x64"
      sha256 "040c254ddeb30f6d592be67d1469dc67fcac14e933fa04dbf690f42820ffd820"
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
