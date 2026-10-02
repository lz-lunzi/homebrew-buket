class Omp < Formula
  desc "AI coding agent for the terminal"
  homepage "https://omp.sh"
  license "MIT"
  version "18.4.12"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.4.12/omp-darwin-arm64"
      sha256 "1a81bd323ba6d67374adf5645fe52e194671416e15c69ef17ac18e32b42c55ff"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.4.12/omp-darwin-x64"
      sha256 "d3305b641d3e62c30f8cd5a44343d219cdc45c3ad9a6c13729df61749ff40ac6"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.4.12/omp-linux-arm64"
      sha256 "7e9c91e9f34765abfd775b8f87c00bb82d5c14025d58770fe4213791452f3182"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.4.12/omp-linux-x64"
      sha256 "8178466631d09c2165c19c14c92ee7f4e3e68c5f41953e8815adfb1214a64999"
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
