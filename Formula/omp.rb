class Omp < Formula
  desc "AI coding agent for the terminal"
  homepage "https://omp.sh"
  license "MIT"
  version "18.1.16"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.1.16/omp-darwin-arm64"
      sha256 "99eed6d45d984d2f13d76832f78782b9aa07862921ab4e98e2d8e31ca8129795"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.1.16/omp-darwin-x64"
      sha256 "78b11d4a9f5884e18589d2a8b10e328f696d5b7da1f6fe46f289bb80f55ffddf"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.1.16/omp-linux-arm64"
      sha256 "d8612389c7af3cf3b69609c9149bff3cf07dcb65774b231d9dc4966b176b9720"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.1.16/omp-linux-x64"
      sha256 "efebefb74359d20362e07341f01a65fc0a259e7bc79454ef08b0ebf5232ab897"
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
