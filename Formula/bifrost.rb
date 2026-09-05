class Bifrost < Formula
  desc "High-performance HTTP/HTTPS/SOCKS5 proxy server written in Rust"
  homepage "https://github.com/bifrost-proxy/bifrost"
  license "MIT"
  version "0.0.189"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/bifrost-proxy/bifrost/releases/download/v0.0.189/bifrost-v0.0.189-aarch64-apple-darwin.tar.xz"
      sha256 "9020130c83e785c03a6841a498c3ac5a65670ddb9a25e360f6b4bcddfa51c213"
    end
    on_intel do
      url "https://github.com/bifrost-proxy/bifrost/releases/download/v0.0.189/bifrost-v0.0.189-x86_64-apple-darwin.tar.xz"
      sha256 "f1f3e597822dbbb44dd420ab66f42119017009c961a320b4a8d02fc457833494"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bifrost-proxy/bifrost/releases/download/v0.0.189/bifrost-v0.0.189-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a67fe3e152aeca6e05fd028cea40086fdd41a794e93049650dff8b1d2bc7b194"
    end
    on_intel do
      url "https://github.com/bifrost-proxy/bifrost/releases/download/v0.0.189/bifrost-v0.0.189-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f18b7728709933e7af125974a8f7019d8f8c434796c6e956e895c79d1c875e46"
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
