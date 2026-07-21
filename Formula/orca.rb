class Orca < Formula
  desc "ADE for working with a fleet of parallel AI agents"
  homepage "https://github.com/stablyai/orca"
  version "1.4.148"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_linux do
    on_arm do
      url "https://github.com/stablyai/orca/releases/download/v#{version}/orca-linux-arm64.AppImage"
      sha256 "c6f1682502cecbe51e5bbf59b2a6281eb83d805d42444268abedd9f16bd1dd2c"
    end
    on_intel do
      url "https://github.com/stablyai/orca/releases/download/v#{version}/orca-linux.AppImage"
      sha256 "8c42d009fc2dc14b8eef7530e0b92cddd66e4c6458ccc311b4ccf5a8b0d5b0ef"
    end
  end

  def install
    bin.install Dir.glob("orca*").first => "orca"
  end

  def caveats
    <<~EOS
      Orca — desktop IDE for parallel AI agent orchestration.

      Launch from terminal:
        orca

      Visit https://github.com/stablyai/orca for documentation.
    EOS
  end

  test do
    assert_path_exists bin/"orca"
  end
end
