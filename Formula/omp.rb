class Omp < Formula
  desc "AI coding agent for the terminal"
  homepage "https://omp.sh"
  license "MIT"
  version "18.3.5"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.3.5/omp-darwin-arm64"
      sha256 "3ad34e91a474ea239674b593a5ff1544727a22f7afd3c8a8729260128a5febd1"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.3.5/omp-darwin-x64"
      sha256 "b0c08f1df0d887e4c256aabbec3893479687ba800906863e30f84926419c6c32"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.3.5/omp-linux-arm64"
      sha256 "54c65b46af9dec489ab0b632fa7eff9a2056a3ced4cdad3e3de25c5ac2f743ca"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.3.5/omp-linux-x64"
      sha256 "2221e3806ffbabeda62b0c505a06db187c2649d00c1f7b5cf0d09187264bf6eb"
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
