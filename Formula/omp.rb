class Omp < Formula
  desc "AI coding agent for the terminal"
  homepage "https://omp.sh"
  license "MIT"

  livecheck do
    url :stable
    regex(/"tag_name"\s*:\s*"v?(\d+(?:\.\d+)+)"/i)
  end

  on_macos do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v16.5.2/omp-darwin-arm64"
      sha256 "7e5d4787c8555729bcb9e0405e06b4d772dc4b21e40330b3b3719ef22618ccb1"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v16.5.2/omp-linux-x64"
      sha256 "cc2c8a958e09adc3432860555174d70f1cbce0be8a86af413ffdcf2ec18cb10e"
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
