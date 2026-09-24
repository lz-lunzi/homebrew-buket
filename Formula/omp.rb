class Omp < Formula
  desc "AI coding agent for the terminal"
  homepage "https://omp.sh"
  license "MIT"
  version "18.3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.3.0/omp-darwin-arm64"
      sha256 "d61fb411f24146bed48dd901b13b5912a297d899ee691dda69c4b5b7ab8c35dc"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.3.0/omp-darwin-x64"
      sha256 "be74498e0edcde7e018247b925f0e0ebf00a7748a1006b3a02eb62ca9e021baf"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.3.0/omp-linux-arm64"
      sha256 "bdfb9c494e17a2fee1956dae16a010a1953574ce4172c4db8efe06fbe477c637"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.3.0/omp-linux-x64"
      sha256 "d2fdaa29affe96e596eb9c78d42f548f1f291df28608631bcc00750a84b94bc3"
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
