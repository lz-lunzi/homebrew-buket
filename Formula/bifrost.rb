class Bifrost < Formula
  desc "High-performance HTTP/HTTPS/SOCKS5 proxy server written in Rust"
  homepage "https://github.com/bifrost-proxy/bifrost"
  license "MIT"
  version "0.0.195"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/bifrost-proxy/bifrost/releases/download/v0.0.195/bifrost-v0.0.195-aarch64-apple-darwin.tar.xz"
      sha256 "7d63650687f1ebc3455b6b8a08719404ec95a16d7ba7b7431e714a7e5385180d"
    end
    on_intel do
      url "https://github.com/bifrost-proxy/bifrost/releases/download/v0.0.195/bifrost-v0.0.195-x86_64-apple-darwin.tar.xz"
      sha256 "e06ea6fab086811f0e6325e4cb2603eb41b95e958877eb51920fe1bee27eaa34"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bifrost-proxy/bifrost/releases/download/v0.0.195/bifrost-v0.0.195-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "d80f717dc580380c79cde5785ce0bafb42fe68d451ee17c4e8e062697ed83585"
    end
    on_intel do
      url "https://github.com/bifrost-proxy/bifrost/releases/download/v0.0.195/bifrost-v0.0.195-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "82688c4f25bb22f3e64b418d65dafdcbfb7000e66e0d2b6706a054e10d95a83b"
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
