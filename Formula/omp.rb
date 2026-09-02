class Omp < Formula
  desc "AI coding agent for the terminal"
  homepage "https://omp.sh"
  license "MIT"
  version "18.1.2"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.1.2/omp-darwin-arm64"
      sha256 "5f2512cce2a154ad2406a4792421c42f022b1335f83dcbde4236f76e50ab35b4"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.1.2/omp-darwin-x64"
      sha256 "fff1ecc1950b45530bc30fac54783c45d93f1bc8a5c49186b1bd796cc6cb62d0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.1.2/omp-linux-arm64"
      sha256 "2865c21a73ae8b893fd5553bf302afc5be8a0bcafa015af99732349d518830da"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.1.2/omp-linux-x64"
      sha256 "c6a306347a57c872bf38587e81132db50490228867e3e179a363a4cf874da1a0"
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
