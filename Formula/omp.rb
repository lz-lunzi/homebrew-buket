class Omp < Formula
  desc "AI coding agent for the terminal"
  homepage "https://omp.sh"
  license "MIT"
  version "17.3.5"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v17.3.5/omp-darwin-arm64"
      sha256 "a6154a4a04b78f9141e0d30d5035284503f2fa034520b64dfda585615a8cfb4a"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v17.3.5/omp-darwin-x64"
      sha256 "cb209b0e2eac2d976980cca0eace1c2513ee1240c981b7d13fb674df92e3ff7a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v17.3.5/omp-linux-arm64"
      sha256 "c79aba4859d71e6ead797bed2f510a9de97c9d576af9842e7fe63dbc9f4157af"
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v17.3.5/omp-linux-x64"
      sha256 "605b4a8a3a137489a91d59e7028c41f3aff20169f352902b41089fbfdf8a253c"
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
