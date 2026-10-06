class Omp < Formula
  desc "AI coding agent for the terminal"
  homepage "https://omp.sh"
  license "MIT"
  version "18.7.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.7.0/omp-darwin-arm64"
      sha256 "1715813a16ad2925a915ef4f8a55a5b82b61759ebcb3768295e8ab26d549d834"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.7.0/omp-darwin-x64"
      sha256 "1eaafe934981436d4da0be7fd625eaf3caac1fababa9a8604b79e97ebf23a6f5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.7.0/omp-linux-arm64"
      sha256 "cb28b001e0a29899f1ae191de1bbba806a184eb15c625a91e277f507eca11579"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.7.0/omp-linux-x64"
      sha256 "03387aceae62386eaefbe96786f6df0e2e2e843ce76926c063a485905b1f4c4f"
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
