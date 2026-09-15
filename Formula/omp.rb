class Omp < Formula
  desc "AI coding agent for the terminal"
  homepage "https://omp.sh"
  license "MIT"
  version "18.2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.2.0/omp-darwin-arm64"
      sha256 "87e028cdcff34e4aa3cbca667c34914496fe3ba6394e818dafabcda3866d8df4"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.2.0/omp-darwin-x64"
      sha256 "44d48c225f6662f82c599db297dcc93aedf88d4847ce208ce498259a9130d648"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.2.0/omp-linux-arm64"
      sha256 "afd6884b192290d02ff79008e891cabee326dea23e853af549aff8ce88064566"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.2.0/omp-linux-x64"
      sha256 "41b67a43f18a7cd33cc0dd772a4fa042cd20ab6c57e6bd451ff6dbe55a7978d8"
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
