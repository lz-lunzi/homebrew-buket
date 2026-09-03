class Omp < Formula
  desc "AI coding agent for the terminal"
  homepage "https://omp.sh"
  license "MIT"
  version "18.1.5"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.1.5/omp-darwin-arm64"
      sha256 "7e6c52bee5f4f934a3f0af26691284f6b84b4f5ea3d73c8b748c2fc68d5c5c7f"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.1.5/omp-darwin-x64"
      sha256 "22391d14580340fff937ce354683cff19e853742d4b875b0b84f0d847d053e87"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.1.5/omp-linux-arm64"
      sha256 "f37035385994200a4f4d48407ad11655854930ab6e54185d2d870697b6aa6b00"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.1.5/omp-linux-x64"
      sha256 "4e36df75e0623b9e4f235bb49a081eb11d74d6dd3e9fe4bb2911b13390d3f43b"
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
