class Bifrost < Formula
  desc "High-performance HTTP/HTTPS/SOCKS5 proxy server written in Rust"
  homepage "https://github.com/bifrost-proxy/bifrost"
  license "MIT"
  version "0.0.188"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/bifrost-proxy/bifrost/releases/download/v0.0.188/bifrost-v0.0.188-aarch64-apple-darwin.tar.xz"
      sha256 "993da94f681f63c546601bd85a8323e46d5110cd4e5523420b7d4c2b4a9da2fa"
    end
    on_intel do
      url "https://github.com/bifrost-proxy/bifrost/releases/download/v0.0.188/bifrost-v0.0.188-x86_64-apple-darwin.tar.xz"
      sha256 "eb7b562dd49621110a38f9c3d2dfa6ba9675c56c4b8ff27941ad64ee7769e437"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bifrost-proxy/bifrost/releases/download/v0.0.188/bifrost-v0.0.188-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b6d99d6667f85b9fd1e3a2c660f6d34c0d794dae9945cef8bc5389062aa06dec"
    end
    on_intel do
      url "https://github.com/bifrost-proxy/bifrost/releases/download/v0.0.188/bifrost-v0.0.188-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e51b7f7822afaafecd7e0dc5fefe584cdb539b03febfa8aa5c21ee647383b9f6"
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
