class Omp < Formula
  desc "AI coding agent for the terminal"
  homepage "https://omp.sh"
  license "MIT"
  version "18.0.4"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.0.4/omp-darwin-arm64"
      sha256 "d493163887bcf8f77b9991ab7219f77712b5b27de6564f7af7283064aca84824"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.0.4/omp-darwin-x64"
      sha256 "f217752f5f579d2b220818462fc515ad333e8a410f1bbfcd6307825b705260f5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.0.4/omp-linux-arm64"
      sha256 "f2b7c8a019681ede314ac165100c1c5b5cd4900139075948da809c004bec5ce7"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.0.4/omp-linux-x64"
      sha256 "94ec42d17d71975a381e20335bb3c005a7fd7eec19b319358df6d22f28e16b37"
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
