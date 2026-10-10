class Omp < Formula
  desc "AI coding agent for the terminal"
  homepage "https://omp.sh"
  license "MIT"
  version "18.8.9"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.8.9/omp-darwin-arm64"
      sha256 "1d084cfbb9587fa1ff76fa77f06ee8680b6a70f92cd207f4a7942e2bd45ae665"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.8.9/omp-darwin-x64"
      sha256 "aa3da0d293fd9b6242884cf88965aae27c37fd233e131434ee4c76159f6d82c5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.8.9/omp-linux-arm64"
      sha256 "c639c57b0b622cbdb48b62a58960f4b6a5b3801300c45cc0f1b50b09ad61450b"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.8.9/omp-linux-x64"
      sha256 "cacc12d5cdd46ff207f3452b36a0d0cfa7c5b8aee0d403aa83c5ab1f46bccb58"
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
