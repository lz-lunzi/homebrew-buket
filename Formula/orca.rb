class Orca < Formula
  desc "IDE for orchestrating AI coding agents across terminals and worktrees"
  homepage "https://onorca.dev/"
  license "MIT"
  version "1.4.194"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/stablyai/orca/releases/download/v#{version}/Orca-#{version}-arm64-mac.zip"
      sha256 "87dee962eaaa40e567b27b914611ce57525354abaf64af381c6a6983afe30c21"
    end
    on_intel do
      url "https://github.com/stablyai/orca/releases/download/v#{version}/Orca-#{version}-mac.zip"
      sha256 "c3dd5237c195ea02eac3c423e5555b4a75a252125b4b0df0e6b5c99fdb1aefe0"
    end
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
    if OS.mac?
      prefix.install Dir["*.app"]
      bin.install_symlink prefix/"Orca.app/Contents/MacOS/Orca" => "orca"
    else
      bin.install Dir.glob("orca-linux*.AppImage").first => "orca"
    end
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
