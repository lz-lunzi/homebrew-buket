class Omp < Formula
  desc "AI coding agent for the terminal"
  homepage "https://omp.sh"
  license "MIT"
  version "17.2.15"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v17.2.15/omp-darwin-arm64"
      sha256 "e280d25bc7ad889c87af101a8b9c8b7aa9853c373acb259eda6007a9659ac2a5"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v17.2.15/omp-darwin-x64"
      sha256 "019281f10e416bc19716c29fc8928b7278573c7a011bcaf22d15dfd39b045d03"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v17.2.15/omp-linux-arm64"
      sha256 "36507ba3d98332f52649d22009ead86f154ab007cb169d68690fa2b0111769ad"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v17.2.15/omp-linux-x64"
      sha256 "fa884941f932f4f5d2046acba971790ae6aae18fd4806472b01f041de670368a"
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
