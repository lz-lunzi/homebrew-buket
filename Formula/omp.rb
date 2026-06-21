class Omp < Formula
  desc "AI coding agent for the terminal — hash-anchored edits, optimized tools, LSP, browser, subagents"
  homepage "https://omp.sh"
  license "MIT"

  livecheck do
    url "https://api.github.com/repos/can1357/oh-my-pi/releases/latest"
    regex(/"tag_name"\s*:\s*"v?(\d+(?:\.\d+)+)"/i)
  end

  on_macos do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v16.1.9/omp-darwin-arm64"
      sha256 "ff55aef11bb451972ea521ab35b82c335cdb3b70f21bf8cd706d77d0e0a0540c"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v16.1.9/omp-darwin-x64"
      sha256 "0bc60b003b541f86b6c31948eee586f54222786473d04c5eb53c942f50116bb8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v16.1.9/omp-linux-arm64"
      sha256 "94ce568fb463fac468aee74948ef11141664df8658cf184e7f7b5c83ab1cd561"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v16.1.9/omp-linux-x64"
      sha256 "63d0fcba060937da6ab110fa8a061daea0cce52dc3d31b380e466c51a1d3a0d4"
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
