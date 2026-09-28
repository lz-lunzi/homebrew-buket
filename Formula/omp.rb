class Omp < Formula
  desc "AI coding agent for the terminal"
  homepage "https://omp.sh"
  license "MIT"
  version "18.4.2"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.4.2/omp-darwin-arm64"
      sha256 "2b49620ca39d835ff313aadd4ec61931732b5db4251a7781d8a5a2305341c14a"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.4.2/omp-darwin-x64"
      sha256 "2b178ca617f0aee1a6dfce7b500b07d57a348e3418fd0713c810555e576db447"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.4.2/omp-linux-arm64"
      sha256 "2c16dc4c146bf80d962e88ebefe87c2d5b30b42f0513eba100d7c1b161abd05b"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.4.2/omp-linux-x64"
      sha256 "55016ef5317af556975f3a3dce02c8db41fc1d05d15b65147814fde019c2e203"
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
