class Omp < Formula
  desc "AI coding agent for the terminal"
  homepage "https://omp.sh"
  license "MIT"
  version "17.3.8"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v17.3.8/omp-darwin-arm64"
      sha256 "84705a1ca833f59afccca2db7aff559e09cb74902e7a5aaf87077a88f3c84b84"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v17.3.8/omp-darwin-x64"
      sha256 "8ea335917741cdd6f5a4a671cd4c6238dfdd27b9a303e9ed357c442877768d6c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v17.3.8/omp-linux-arm64"
      sha256 "5d97dba8068c9c3b19bc2949567798e0a839dec5f11c458b4c642bfe0f4d14a0"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v17.3.8/omp-linux-x64"
      sha256 "efdb54f0054e80afe1c05c09f43d5ced09ce8ec8b75c3fb6b0ca5ce4805b383f"
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
