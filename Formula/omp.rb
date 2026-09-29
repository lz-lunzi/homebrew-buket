class Omp < Formula
  desc "AI coding agent for the terminal"
  homepage "https://omp.sh"
  license "MIT"
  version "18.4.4"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.4.4/omp-darwin-arm64"
      sha256 "e76e02821242fb36844676a9dfb79fbe5fb069d93ef3bf62625ec339fe9d092b"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.4.4/omp-darwin-x64"
      sha256 "18541fd15a7707195a9041b748f2b1d647f39514ad20d9c41df53044244deab5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.4.4/omp-linux-arm64"
      sha256 "602eefddc0fd87043f8f08d8628d72592e5802c003a05f203f1ecbc63a8fdd30"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.4.4/omp-linux-x64"
      sha256 "24c830fceb0bd6884bf5bf2c7a2b7407bc23fafe655e924c695ef9be308e46f3"
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
