class Octop < Formula
  desc "Self-hosted AI assistant with multi-user, multi-agent support (portable)"
  homepage "https://github.com/TencentCloud/Octop"
  license "MIT"
  version "1.0.2b6"

  livecheck do
    url "https://github.com/TencentCloud/Octop/releases/latest"
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/TencentCloud/Octop/releases/download/v1.0.2b6/Octop-portable-darwin-arm64-1.0.2b6.zip"
      sha256 "ca7c2c7363e8d976273ac7e31062cd41f7b4d64afd5bb47ccf1e117099361370"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/TencentCloud/Octop/releases/download/v1.0.2b6/Octop-portable-linux-arm64-1.0.2b6.zip"
      sha256 "9dbbc03a58657e1f3a78ee4bb424f52b99f67b120c55545861220bfafe9c7296"
    end
    on_intel do
      url "https://github.com/TencentCloud/Octop/releases/download/v1.0.2b6/Octop-portable-linux-amd64-1.0.2b6.zip"
      sha256 "6d5e219765b6dad46d3f8b0e9973e5462aa302b211a43945e49e2672771859ed"
    end
  end

  def install
    # Portable zip layout: Octop-<plat>/{start.sh,runtime,packages,launch.py}
    libexec.install Dir["Octop-*"]
    staging = Pathname.new(Dir[libexec/"Octop-*"].first)
    chmod 0755, staging/"start.sh"
    (bin/"octop").write_exec_script staging/"start.sh"
  end

  def caveats
    <<~EOS
      Octop portable — self-hosted AI assistant (multi-user, multi-agent).

      Start the server (dashboard at http://127.0.0.1:8088):
        octop

      Custom data dir / listen address:
        octop --home ~/octop-data --host 0.0.0.0 --port 8088

      Visit https://github.com/TencentCloud/Octop for documentation.
    EOS
  end

  test do
    assert_match "Octop green portable launcher", shell_output("#{bin}/octop -h")
  end
end
