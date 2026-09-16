class Omp < Formula
  desc "AI coding agent for the terminal"
  homepage "https://omp.sh"
  license "MIT"
  version "18.2.2"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.2.2/omp-darwin-arm64"
      sha256 "e0302a99643efefb62bf3d0601d5d84ebab6ed1f3ad105cc2874c8274af448a9"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.2.2/omp-darwin-x64"
      sha256 "4a8ec4d255165b63874c0620ff845502aca0839b06a4c62e036b231a6da5db56"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.2.2/omp-linux-arm64"
      sha256 "27e8def02230dc8334172c4a0e850c5bfab194558817d454aa6edcc942ce1100"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.2.2/omp-linux-x64"
      sha256 "77c3520ab8ef8318dda02a0715e3b6e69589c427dc23f90a4bb97650caa72f72"
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
