class Omp < Formula
  desc "AI coding agent for the terminal"
  homepage "https://omp.sh"
  license "MIT"
  version "18.1.11"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.1.11/omp-darwin-arm64"
      sha256 "a81b2a98d99d5b34491d25232020d53cb0e5526095ef21c4cb9d4283e6511807"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.1.11/omp-darwin-x64"
      sha256 "a807645d114470a1e2ad72b3646f118532141a36b0de062478fef999a8c3fac3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.1.11/omp-linux-arm64"
      sha256 "20dd6c946dcb61e2f79df83feeea513ae7ee93c71190d1cb8e7f81a82d5e5e13"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.1.11/omp-linux-x64"
      sha256 "2b2c785bbbafd3b43fb6096e4ae63a0342c4d8069de2f875a9b76ea9947c2383"
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
