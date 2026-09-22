class Omp < Formula
  desc "AI coding agent for the terminal"
  homepage "https://omp.sh"
  license "MIT"
  version "18.2.9"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.2.9/omp-darwin-arm64"
      sha256 "42f0e972a355079aab7a35f2a74fe7bf3b46d500d44aa876770ad2b8a1f5506e"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.2.9/omp-darwin-x64"
      sha256 "87f357f9bb22c9c4c1b02d94fe85996d95f28db3b75a53040e59733391b5947d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.2.9/omp-linux-arm64"
      sha256 "c455d265bab227d25ee7ae8c1e1b5a20d29354ff91d2fe731d612e140347cd2d"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.2.9/omp-linux-x64"
      sha256 "7de7be671bf27d5a2a15fff791490e319fedc59e5eb1759cea2060e142c086ec"
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
