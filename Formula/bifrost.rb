class Bifrost < Formula
  desc "High-performance HTTP/HTTPS/SOCKS5 proxy server written in Rust"
  homepage "https://github.com/bifrost-proxy/bifrost"
  license "MIT"
  version "0.0.192"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/bifrost-proxy/bifrost/releases/download/v0.0.192/bifrost-v0.0.192-aarch64-apple-darwin.tar.xz"
      sha256 "c51391a81ff63449d11c5e76fbc14f9276aaef283bf453f4e5e4902cdc9040c7"
    end
    on_intel do
      url "https://github.com/bifrost-proxy/bifrost/releases/download/v0.0.192/bifrost-v0.0.192-x86_64-apple-darwin.tar.xz"
      sha256 "1014c8cdde025ff337e1b9d72b8a4507719e31a1a51eb426c0cc96c2d2c580af"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bifrost-proxy/bifrost/releases/download/v0.0.192/bifrost-v0.0.192-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "d884d0164ed27ca3f86c156bd9c967fba5ff0ebb1da1bdad7e2d63ff7c8a9b2b"
    end
    on_intel do
      url "https://github.com/bifrost-proxy/bifrost/releases/download/v0.0.192/bifrost-v0.0.192-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a134af538cbfd22df68ae87df5f4cfaebd7739f26cb6d910691090f712e03f3a"
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
