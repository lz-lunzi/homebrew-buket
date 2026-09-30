class Orca < Formula
  desc "IDE for orchestrating AI coding agents across terminals and worktrees"
  homepage "https://onorca.dev/"
  license "MIT"
  version "1.4.217"

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
      url "https://github.com/stablyai/orca/releases/download/v1.4.217/orca-linux-arm64.AppImage"
      sha256 "daf3be3c52beca2723ddd4e3bc42452bf93099719ee29dc73791090af1c693ce"
    end
    on_intel do
      url "https://github.com/stablyai/orca/releases/download/v1.4.217/orca-linux.AppImage"
      sha256 "b82943d14e015f6a3caa158c35115a014e3679b32251c346aa753a08a57b3082"
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
