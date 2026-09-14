class Omp < Formula
  desc "AI coding agent for the terminal"
  homepage "https://omp.sh"
  license "MIT"
  version "18.1.22"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.1.22/omp-darwin-arm64"
      sha256 "e75ea51aa20fa67564150d616afd69062f39e0e5ddb3b765741a0c045062c8eb"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.1.22/omp-darwin-x64"
      sha256 "fd378c9115d3a0bdcd52ab48935fbf438d92a6b173900a3e5a682c6b650ac1c3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.1.22/omp-linux-arm64"
      sha256 "62433d49063eed2e90d3cb14729b3a608d6665348f9fdddb8757680b026059ec"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.1.22/omp-linux-x64"
      sha256 "9ccddf1091e01e08fea1f8e1208f8901cc90d5d098b16581672eeab03f118b81"
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
