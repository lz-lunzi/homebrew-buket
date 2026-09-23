class Omp < Formula
  desc "AI coding agent for the terminal"
  homepage "https://omp.sh"
  license "MIT"
  version "18.2.11"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.2.11/omp-darwin-arm64"
      sha256 "faeffd57674cffa253e2f127d72ddfe6dcd81e1eb91eb5d2148913e62a010a28"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.2.11/omp-darwin-x64"
      sha256 "1271717213125a60db7882b46bb55e1ff70f7929ae801ff1176f732433835f98"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.2.11/omp-linux-arm64"
      sha256 "c115f95a0a0081d3724a3c878231fb8c3b2fdb25ad5ad6c3b30d152a82b3939e"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.2.11/omp-linux-x64"
      sha256 "97cf39557bf3d98327dd4c9814380b7e6bcb76e41169edd9b0ff30424c733a2a"
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
