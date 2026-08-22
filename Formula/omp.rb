class Omp < Formula
  desc "AI coding agent for the terminal"
  homepage "https://omp.sh"
  license "MIT"
  version "17.4.2"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v17.4.2/omp-darwin-arm64"
      sha256 "357d5e7a00ec3d352cac5dfcfeba15781e1e2d0a9074479222717a7b5ddd0406"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v17.4.2/omp-darwin-x64"
      sha256 "3a552044dc4126bde61c7c4708b923a082c9e36732cebca6001794d27c7ec5a1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v17.4.2/omp-linux-arm64"
      sha256 "a4fde8f82a6a229b815b5291dc111db4c60532cb2df8484b4ac2654116cbdbfc"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v17.4.2/omp-linux-x64"
      sha256 "218a8684c2b11256b47e28ba131adfb2a03e988eddd8567bd836b7c51dd02005"
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
