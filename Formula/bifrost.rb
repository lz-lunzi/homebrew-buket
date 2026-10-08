class Bifrost < Formula
  desc "High-performance HTTP/HTTPS/SOCKS5 proxy server written in Rust"
  homepage "https://github.com/bifrost-proxy/bifrost"
  license "MIT"
  version "0.0.198"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/bifrost-proxy/bifrost/releases/download/v0.0.198/bifrost-v0.0.198-aarch64-apple-darwin.tar.xz"
      sha256 "370693e8dd840a921bfa396806c82143ebbd3ff03e3e0fbca8deb33f6765007f"
    end
    on_intel do
      url "https://github.com/bifrost-proxy/bifrost/releases/download/v0.0.198/bifrost-v0.0.198-x86_64-apple-darwin.tar.xz"
      sha256 "fc6d223624a7f28d518c6a36af2f258767c6796445b54f7f22e18e991a7dc31a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bifrost-proxy/bifrost/releases/download/v0.0.198/bifrost-v0.0.198-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b0f5aad02bca740193a2e95cfcb1ed85cc3d0f6f97de09493ed2569161cf2834"
    end
    on_intel do
      url "https://github.com/bifrost-proxy/bifrost/releases/download/v0.0.198/bifrost-v0.0.198-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "01cded8a668a4f8fd3ff31eae7248260dcb9337ee887812eb2f03879f4c86572"
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
