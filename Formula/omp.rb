class Omp < Formula
  desc "AI coding agent for the terminal"
  homepage "https://omp.sh"
  license "MIT"
  version "18.2.8"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.2.8/omp-darwin-arm64"
      sha256 "cf8d34a7fe6f60de1acbe74f29c82026e4c07888e9d89f7ebceeb922159e5787"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.2.8/omp-darwin-x64"
      sha256 "b385c2bbacddc09b266ec19ba95ebb2882301293d49390d7fd32cc3a12a1da41"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.2.8/omp-linux-arm64"
      sha256 "a9aa63e43c95ccaa0683e9fed03463c401829e220ad2bbc414b341d2d49e5806"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.2.8/omp-linux-x64"
      sha256 "b0c01da7339d87fd5d26d7faa7b61c131a50648399962783899fd93a6d8b1d65"
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
