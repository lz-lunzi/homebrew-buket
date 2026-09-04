class Omp < Formula
  desc "AI coding agent for the terminal"
  homepage "https://omp.sh"
  license "MIT"
  version "18.1.8"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.1.8/omp-darwin-arm64"
      sha256 "500f8c7a16b2baa0924f883c8b1fa91ae76c87d2a938349cf8319ebd61a981a5"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.1.8/omp-darwin-x64"
      sha256 "c84e417d6e18e0ddc77c7c675b3b7cb62cb564bd747397f7213032e63ac7f420"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.1.8/omp-linux-arm64"
      sha256 "4f75c58a69dc97a2a9fa61e354f0ce8b96f231c5afe850d45529a05400700bfd"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.1.8/omp-linux-x64"
      sha256 "c09d5a79c44b6435b5917b7d5c847b0951d48351e71dbaf9fd06bc2e285772dd"
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
