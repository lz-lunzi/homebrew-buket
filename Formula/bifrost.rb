class Bifrost < Formula
  desc "High-performance HTTP/HTTPS/SOCKS5 proxy server written in Rust"
  homepage "https://github.com/bifrost-proxy/bifrost"
  license "MIT"
  version "0.0.191"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/bifrost-proxy/bifrost/releases/download/v0.0.191/bifrost-v0.0.191-aarch64-apple-darwin.tar.xz"
      sha256 "1816c9777e6cada1079a86c411eedfc3dcc3627e31a399a217293a0fa33c8b69"
    end
    on_intel do
      url "https://github.com/bifrost-proxy/bifrost/releases/download/v0.0.191/bifrost-v0.0.191-x86_64-apple-darwin.tar.xz"
      sha256 "c2a1fca54412fa911e50f7788fce08deb04e69c1029e2eeb0e43f67c8aa57a69"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bifrost-proxy/bifrost/releases/download/v0.0.191/bifrost-v0.0.191-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "3f45fd7e1a2c15390dd3a012094dd9253b41e95a448e3a89e974aad27b0c3c80"
    end
    on_intel do
      url "https://github.com/bifrost-proxy/bifrost/releases/download/v0.0.191/bifrost-v0.0.191-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f7f1af114e3b972a8515916d31ffadd1c0dddf4d89a59aefb7b27f0bb41b0731"
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
