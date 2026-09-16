class Omp < Formula
  desc "AI coding agent for the terminal"
  homepage "https://omp.sh"
  license "MIT"
  version "18.2.1"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.2.1/omp-darwin-arm64"
      sha256 "ac673868a1598b4beda98dc6ce2148f24afabc42816c702b2dac5f79f0d861de"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.2.1/omp-darwin-x64"
      sha256 "6a5e678b95fdceec03eb1bdcd5046ff76e25eb092acab5d52a785e7582b4467e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.2.1/omp-linux-arm64"
      sha256 "01ca88eddc6fba11367259dcffc4293fd9458c918f6e5012af35d73338ee1bdd"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.2.1/omp-linux-x64"
      sha256 "9c76485c4e65875678b88c7926c7e6891d488796676f359de9c4df584c886fc9"
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
