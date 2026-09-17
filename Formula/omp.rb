class Omp < Formula
  desc "AI coding agent for the terminal"
  homepage "https://omp.sh"
  license "MIT"
  version "18.2.3"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.2.3/omp-darwin-arm64"
      sha256 "5c9f8e359eed201aa2848a34184c3b12641ab3e29d303738fabc97add2f129fe"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.2.3/omp-darwin-x64"
      sha256 "2775f73538fbee58e30881e560b4d06b5504fa4d9dafef8323348eb7190c4d05"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.2.3/omp-linux-arm64"
      sha256 "37e21b463e16a541d20a94ae422b554ef59fc3e41cc7e275d2759f66041ca5ef"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v18.2.3/omp-linux-x64"
      sha256 "f85bdfb4a763d3399ddd18413f880b26b36da765aa75bd5fcc7d252239c7f17a"
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
