class Omp < Formula
  desc "AI coding agent for the terminal"
  homepage "https://omp.sh"
  license "MIT"
  version "18.1.10"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.1.10/omp-darwin-arm64"
      sha256 "f93613f5cc66a22e4368e955f7d121b9508306d4153b2932318e5d45ecf13a44"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.1.10/omp-darwin-x64"
      sha256 "619a8a6ee7cba1e1a877ff8c7a7e4b73a2101baad6e9cc274841ff1db4b39b86"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.1.10/omp-linux-arm64"
      sha256 "aba7beb612459789e539db980c95680c26d26ca0d67776152fce70cc6e1dac06"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.1.10/omp-linux-x64"
      sha256 "e91d5598ee47e1d4099fd8686dc9f61c9b755f2ea077d5f1774aba1072321f9e"
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
