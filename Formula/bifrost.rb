class Bifrost < Formula
  desc "High-performance HTTP/HTTPS/SOCKS5 proxy server written in Rust"
  homepage "https://github.com/bifrost-proxy/bifrost"
  license "MIT"
  version "0.0.197"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/bifrost-proxy/bifrost/releases/download/v0.0.197/bifrost-v0.0.197-aarch64-apple-darwin.tar.xz"
      sha256 "4c5d9885fa9753280a9d7c98a9572959ff99e3942d7acea799c1f041d605ecd9"
    end
    on_intel do
      url "https://github.com/bifrost-proxy/bifrost/releases/download/v0.0.197/bifrost-v0.0.197-x86_64-apple-darwin.tar.xz"
      sha256 "b1b1a366cdf6f0be589eff0f1bf5c3c3507a86d4bfba6da84be238d1f0f6c10f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bifrost-proxy/bifrost/releases/download/v0.0.197/bifrost-v0.0.197-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "c7703607ec2a652e58147783600cfa78c2579921c193c7e9a9ce4aba3357cdd6"
    end
    on_intel do
      url "https://github.com/bifrost-proxy/bifrost/releases/download/v0.0.197/bifrost-v0.0.197-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ad6f83a1195d71b6e396d9be2fe1aa65913c440db19e013258399242bdd20a60"
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
