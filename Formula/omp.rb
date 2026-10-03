class Omp < Formula
  desc "AI coding agent for the terminal"
  homepage "https://omp.sh"
  license "MIT"
  version "18.5.1"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.5.1/omp-darwin-arm64"
      sha256 "2abd8161abf1354c592547e669e2a7a9f6e63be1156fa65865d2a7db0b11ff79"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.5.1/omp-darwin-x64"
      sha256 "9e796c6d9aa1ebed9fcac20d5937b57b3af15b964eba8483add59667d315949c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.5.1/omp-linux-arm64"
      sha256 "e7b81b96b3f9f391ec8afc7ee64c052ce1783290f88bbb59ba36d15b3b4e927c"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.5.1/omp-linux-x64"
      sha256 "fb7638e82f0c9d087e96e15d3eb83a662d92374cd907187d6d4d2605e39f1e3a"
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
