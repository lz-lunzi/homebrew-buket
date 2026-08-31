class Omp < Formula
  desc "AI coding agent for the terminal"
  homepage "https://omp.sh"
  license "MIT"
  version "18.0.11"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.0.11/omp-darwin-arm64"
      sha256 "88b4a3e68e19904b8fcc1ba4b319ef68795f4fe06a6d101d564fc482cb0cc252"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.0.11/omp-darwin-x64"
      sha256 "80f7dc579b88d0e55b5ce4eb4d0e940711af69328f4ffb2c293b8e1497ff7a2d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.0.11/omp-linux-arm64"
      sha256 "e5f77cb65aa2dc777a8a5932be3b2e6a44271c8df2eb209cea6f04f212f3f010"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.0.11/omp-linux-x64"
      sha256 "6054460b29e9bad5eba78336f291e1979c2fa0a5cd96fc2d92afd666cc681d26"
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
