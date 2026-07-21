class Omp < Formula
  desc "AI coding agent for the terminal"
  homepage "https://omp.sh"
  license "MIT"
  version "17.0.6"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v17.0.6/omp-darwin-arm64"
      sha256 "d747470bcff0412e5bde7860f5dead7de15aad6b973a4b46c34f8527d9d6a4b9"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v17.0.6/omp-darwin-x64"
      sha256 "9e5b4560b61fc4373f604cba9e2cc3bdab04549e830f3d5ecd80b1f7facc86bc"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v17.0.6/omp-linux-arm64"
      sha256 "4d2f3e9948f81f4c3813b5c89e5eda4bdcd42ef22285d40cf48402ebfa15436d"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v17.0.6/omp-linux-x64"
      sha256 "27fec143aa646cae5eae9b3a0677c54d43465fc49a79b161bac739dbba244c8c"
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
