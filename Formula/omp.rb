class Omp < Formula
  desc "AI coding agent for the terminal"
  homepage "https://omp.sh"
  license "MIT"
  version "18.8.3"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.8.3/omp-darwin-arm64"
      sha256 "4421538b6a988527eedf08ec32aa83e27ec31227a3f91028d8f59c103e537b60"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.8.3/omp-darwin-x64"
      sha256 "2aa5e35fb2c5b1ac1a236efcb245a60e533bd20b95adc14879c166c0cff12cdf"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.8.3/omp-linux-arm64"
      sha256 "170852b7815ef74e1212f87e69fa7f2730f31716479177df436d3eaa832d8ca5"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.8.3/omp-linux-x64"
      sha256 "8cb6d6a0035a3c5d9c40a58852ca361569eafc2cecbbeef4521e0fefc8ccbc37"
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
