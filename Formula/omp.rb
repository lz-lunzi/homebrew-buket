class Omp < Formula
  desc "AI coding agent for the terminal"
  homepage "https://omp.sh"
  license "MIT"
  version "18.6.1"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.6.1/omp-darwin-arm64"
      sha256 "b5ca5cd17b8cc09ece36845988fd401f7d1002e1ab5b95600e0f328924246d52"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.6.1/omp-darwin-x64"
      sha256 "4c8ca5f8dfe98076fb6888f76465a43be5503ab3a183cbe20cc1748f9d5b9ba8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.6.1/omp-linux-arm64"
      sha256 "cb7815330bb117877e4e133562ea82e3001ee470e47393552507b5a7f0407f4a"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.6.1/omp-linux-x64"
      sha256 "c92a6846d02984e84f07c6362d18add3783f528f494ffcf1e0f26e594f327463"
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
