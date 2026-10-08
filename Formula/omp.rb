class Omp < Formula
  desc "AI coding agent for the terminal"
  homepage "https://omp.sh"
  license "MIT"
  version "18.8.6"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.8.6/omp-darwin-arm64"
      sha256 "31faa0ee8420a13a783f4ca56d98f974e4a9f9081d269057a099f7eb618d1133"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.8.6/omp-darwin-x64"
      sha256 "94395b644479c6900c09843a03b581eda4c197946c91c73ab581ef6a48bb0367"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.8.6/omp-linux-arm64"
      sha256 "a6bf1405877a739965586fcf973136f72078d2e6dc288905fab08588469c13cf"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.8.6/omp-linux-x64"
      sha256 "877acdc48384b80fe4c083b1e610433d28922dd9fccde9ea430aaace8765b19b"
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
