class Bifrost < Formula
  desc "High-performance HTTP/HTTPS/SOCKS5 proxy server written in Rust"
  homepage "https://github.com/bifrost-proxy/bifrost"
  license "MIT"
  version "0.0.196"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/bifrost-proxy/bifrost/releases/download/v0.0.196/bifrost-v0.0.196-aarch64-apple-darwin.tar.xz"
      sha256 "81183adabf700428b8f2312dacdec631a9939dddbb65a5faeac2831341663f03"
    end
    on_intel do
      url "https://github.com/bifrost-proxy/bifrost/releases/download/v0.0.196/bifrost-v0.0.196-x86_64-apple-darwin.tar.xz"
      sha256 "db8a44a620bf11083abfcbd6c65bd5748759efc34baeb972b010465fb0c62a4e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bifrost-proxy/bifrost/releases/download/v0.0.196/bifrost-v0.0.196-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "737433bddfa88486f80f59122b63440d9e7e992441e7bd9f88ecf736600bc949"
    end
    on_intel do
      url "https://github.com/bifrost-proxy/bifrost/releases/download/v0.0.196/bifrost-v0.0.196-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d23796ae574203bd38aed7357ce9f5edcd410f72a750bf273916bc53a063d7c5"
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
