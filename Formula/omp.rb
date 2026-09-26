class Omp < Formula
  desc "AI coding agent for the terminal"
  homepage "https://omp.sh"
  license "MIT"
  version "18.3.2"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.3.2/omp-darwin-arm64"
      sha256 "9fccf2cdd7a472c93cb54d99d95d914c86b5f41652054e3cdd0b17c5d28393a6"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.3.2/omp-darwin-x64"
      sha256 "695d3cfd3dc31198362f0be4344dfe64dcc4655fb9ef3316d94368ad7af294d6"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.3.2/omp-linux-arm64"
      sha256 "f56f4775abbf269c481c78799691eaa59a7d69644fa7d592c775e2c65f7b13da"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.3.2/omp-linux-x64"
      sha256 "8cbbcd4bea7a7b86116a13352f31e3778fd4d93df931036bb1771738b0702534"
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
