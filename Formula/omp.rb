class Omp < Formula
  desc "AI coding agent for the terminal"
  homepage "https://omp.sh"
  license "MIT"
  version "18.4.5"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.4.5/omp-darwin-arm64"
      sha256 "64f5d0a99a2c5b5d9b453a7666257306244ac4c6fd8fdbe0e760bf3449fc8ea6"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.4.5/omp-darwin-x64"
      sha256 "823cdd2202cbe336908c0d7a4add4cb063048e000fa9b2083b8576755d1c2523"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.4.5/omp-linux-arm64"
      sha256 "3dcf6a7f847b8c2f7bc5294c52a09151e858578ae3610655b82bf97ffa120a72"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.4.5/omp-linux-x64"
      sha256 "42c710239b3fc30b9759424f973c6c143709935d5752be7eec8d7b011f40d864"
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
