class Bifrost < Formula
  desc "High-performance HTTP/HTTPS/SOCKS5 proxy server written in Rust"
  homepage "https://github.com/bifrost-proxy/bifrost"
  license "MIT"
  version "0.0.193"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/bifrost-proxy/bifrost/releases/download/v0.0.193/bifrost-v0.0.193-aarch64-apple-darwin.tar.xz"
      sha256 "474167aff8010735d4b8fe8973afb1902f1facd2a8e76f9d47cfcb090c9fc827"
    end
    on_intel do
      url "https://github.com/bifrost-proxy/bifrost/releases/download/v0.0.193/bifrost-v0.0.193-x86_64-apple-darwin.tar.xz"
      sha256 "3047e9df885cc4d2850b420621a4925802e1c22d1c27baa2396b8841d40a7d1e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bifrost-proxy/bifrost/releases/download/v0.0.193/bifrost-v0.0.193-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "853ca7dac69b7d0eabb3a8ba70c7223765571c8bee34345665d9d3f2f6a32cdb"
    end
    on_intel do
      url "https://github.com/bifrost-proxy/bifrost/releases/download/v0.0.193/bifrost-v0.0.193-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "7f3080bf8ff0c2001e721f8ede53c1bb389791f103d55e3e07f5a53ad6c600f4"
    end
  end

  def install
    bin.install Dir.glob("*/bifrost").first
  end

  def caveats
    <<~EOS
      Bifrost is a high-performance proxy server written in Rust.

      Start the proxy:
        bifrost start

      Start on a specific port:
        bifrost -p 9900 start

      For HTTPS interception, export and trust the CA certificate:
        bifrost ca export

      Web UI: http://127.0.0.1:<port>/_bifrost/

      Visit https://github.com/bifrost-proxy/bifrost for documentation.
    EOS
  end

  test do
    assert_match "bifrost", shell_output("#{bin}/bifrost --version")
  end
end
