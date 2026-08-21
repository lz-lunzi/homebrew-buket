class Omp < Formula
  desc "AI coding agent for the terminal"
  homepage "https://omp.sh"
  license "MIT"
  version "17.4.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v17.4.0/omp-darwin-arm64"
      sha256 "861ac3d7a76499dbc36e6ec8769b58b61a962daac2b4775ce545474d9030e6ba"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v17.4.0/omp-darwin-x64"
      sha256 "1efd3695430dfddd824e431f9b968bde151a1880ea9d9b5870e3631d58d4d927"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v17.4.0/omp-linux-arm64"
      sha256 "b5b054cca197651d3dd0b7fae0bf6fe0d2cd653e8cbedb623d26faced404aee6"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v17.4.0/omp-linux-x64"
      sha256 "6d5431c69fd6db9771abd51ac76df8820fd718ae33ac654a805fd7fb44b685c7"
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
