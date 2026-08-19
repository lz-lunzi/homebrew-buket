class Omp < Formula
  desc "AI coding agent for the terminal"
  homepage "https://omp.sh"
  license "MIT"
  version "17.3.7"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v17.3.7/omp-darwin-arm64"
      sha256 "d79a735cded3368ad6e77e988f7dc303afeb0331a2dd6ff4666e694512de2e09"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v17.3.7/omp-darwin-x64"
      sha256 "bd94d657d89f818b89fc6f48ca1d0d3cd344942a1c26886fee6e107e687a99e2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v17.3.7/omp-linux-arm64"
      sha256 "8c73618928f8441118eb5783e4b0480294f9741d7fe9d59bcf27eb8b4ac61bec"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v17.3.7/omp-linux-x64"
      sha256 "4ee6ed283be10211d473e9dd45b127f2229820df3e2722a5a305b9a7f977eb83"
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
