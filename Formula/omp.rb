class Omp < Formula
  desc "AI coding agent for the terminal"
  homepage "https://omp.sh"
  license "MIT"
  version "18.1.15"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.1.15/omp-darwin-arm64"
      sha256 "e1e090262f7470d51360ea943d80c3ef03d6178e573b03d0c3d21af5d424e8be"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.1.15/omp-darwin-x64"
      sha256 "79dc22410795b8450e9f41b013c9459204a5c2958d898ee6e1730839b59bb4dc"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.1.15/omp-linux-arm64"
      sha256 "2e1142ccd4bb76413b63a05711ac51c7b95551f36387ef295661bb86f0576189"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.1.15/omp-linux-x64"
      sha256 "747518a41fbb32ac47491b4677a7a921d0d9e5977ae006c358d6836813149adc"
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
