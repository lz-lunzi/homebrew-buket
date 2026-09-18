class Omp < Formula
  desc "AI coding agent for the terminal"
  homepage "https://omp.sh"
  license "MIT"
  version "18.2.6"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.2.6/omp-darwin-arm64"
      sha256 "d498da40d577e1ffa681ca8632c2ea40a9f722a08b880412011d37dffee9513a"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.2.6/omp-darwin-x64"
      sha256 "d558800fa326abc68ae3cbbb3e536322ec643bdcfddc71e6a988857dbe1a94a3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.2.6/omp-linux-arm64"
      sha256 "07245cbe050c3999ab5cea9babfe84e7e8819d2f4d5e49bef47c0aacb6b957e4"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.2.6/omp-linux-x64"
      sha256 "0f38598c91e823d8cce07f151ec3999d51f213fb2cc3e07d89f1af8eef9247a2"
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
