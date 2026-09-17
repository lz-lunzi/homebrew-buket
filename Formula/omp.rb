class Omp < Formula
  desc "AI coding agent for the terminal"
  homepage "https://omp.sh"
  license "MIT"
  version "18.2.4"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.2.4/omp-darwin-arm64"
      sha256 "1a54cf39713ec1443a6323ed716f9b972af325065903ed5c0f0ca1bb626da9ba"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.2.4/omp-darwin-x64"
      sha256 "780a47a5e5668807f5ac1ca37067ddbc528a64edcdf964286bf346f7a83e0609"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.2.4/omp-linux-arm64"
      sha256 "59fe68eee9103494016e22d4261c81ac64a3493df5a9b54816bc064a44fad7cf"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.2.4/omp-linux-x64"
      sha256 "61b4cd50ceaea70baccae7b52a22034469130ea2985a0b2e9adc0f7b3a77a85f"
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
