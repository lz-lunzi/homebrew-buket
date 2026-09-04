class Bifrost < Formula
  desc "High-performance HTTP/HTTPS/SOCKS5 proxy server written in Rust"
  homepage "https://github.com/bifrost-proxy/bifrost"
  license "MIT"
  version "0.0.187"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/bifrost-proxy/bifrost/releases/download/v0.0.187/bifrost-v0.0.187-aarch64-apple-darwin.tar.xz"
      sha256 "070e65b5556641498fb1d77115c9a7aa408748f5d670f0fa1bcc07ffd0ea1140"
    end
    on_intel do
      url "https://github.com/bifrost-proxy/bifrost/releases/download/v0.0.187/bifrost-v0.0.187-x86_64-apple-darwin.tar.xz"
      sha256 "3d077309065beb111520071f0da2b7eca0041af491567528cb25a357878ef05d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bifrost-proxy/bifrost/releases/download/v0.0.187/bifrost-v0.0.187-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "2cfa7b1816d2b318adb770cbcca32b8ea8e7f479d6d39e034dc8a623ea1df85a"
    end
    on_intel do
      url "https://github.com/bifrost-proxy/bifrost/releases/download/v0.0.187/bifrost-v0.0.187-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "819551a57481ecfe1cd8a5f2fe2991744878a39f3edc6460fe629f661fadaaee"
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
