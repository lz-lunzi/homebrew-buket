class Omp < Formula
  desc "AI coding agent for the terminal"
  homepage "https://omp.sh"
  license "MIT"
  version "18.4.9"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.4.9/omp-darwin-arm64"
      sha256 "88c8ff6734bd62b9fe65004f265218eed8e5b8695e64da1172587f5aeb468681"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.4.9/omp-darwin-x64"
      sha256 "ac5b866d8e6f380836cc77c92253d6596e4b67932a95d02bd55a3ebc8c5c3845"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.4.9/omp-linux-arm64"
      sha256 "c86ac994dd9a99b1f8df28b85c9ccc909c81f64c68f9e30039ee980a05308438"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.4.9/omp-linux-x64"
      sha256 "fe1ec455e3aa4536efc8e28b1023113de94b97e7dd68c726964dadeb488a1753"
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
