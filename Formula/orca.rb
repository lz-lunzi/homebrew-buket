class Orca < Formula
  desc "IDE for orchestrating AI coding agents across terminals and worktrees"
  homepage "https://onorca.dev/"
  license "MIT"
  version "1.4.188"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_linux do
    on_arm do
      url "https://github.com/stablyai/orca/releases/download/v#{version}/orca-linux-arm64.AppImage"
      sha256 "edb96cf68e4c5d9442b913e82cad5b6c23a6399f8398e8f4798955bbb9c94918"
    end
    on_intel do
      url "https://github.com/stablyai/orca/releases/download/v#{version}/orca-linux.AppImage"
      sha256 "2e70cb5e199741e5602a7060825575319f5e03bc2faa4b89cd27328f3f55d4b4"
    end
  end

  def install
    # AppImage is a single self-contained executable; install as-is.
    bin.install Dir.glob("orca-linux*.AppImage").first => "orca"
  end

  def caveats
    <<~EOS
      Orca — IDE for orchestrating AI coding agents.

      Start the app:
        orca

      For headless / server use:
        orca serve

      Visit https://onorca.dev/ for documentation.
    EOS
  end

  test do
    assert_match "orca", shell_output("#{bin}/orca --version")
  end
end
