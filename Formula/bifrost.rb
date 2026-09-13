class Bifrost < Formula
  desc "High-performance HTTP/HTTPS/SOCKS5 proxy server written in Rust"
  homepage "https://github.com/bifrost-proxy/bifrost"
  license "MIT"
  version "0.0.194"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/bifrost-proxy/bifrost/releases/download/v0.0.194/bifrost-v0.0.194-aarch64-apple-darwin.tar.xz"
      sha256 "c8485f3f3d84fa7d25d8ad1f383ad769810f5aee7f873f3ff4f291eb561dfae0"
    end
    on_intel do
      url "https://github.com/bifrost-proxy/bifrost/releases/download/v0.0.194/bifrost-v0.0.194-x86_64-apple-darwin.tar.xz"
      sha256 "48a49276c766c6dac40cd9f5b278e189ccc2491c8d011fa69ae3898c53af0fa9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bifrost-proxy/bifrost/releases/download/v0.0.194/bifrost-v0.0.194-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b2e5364c8e48b3b38bc382f5f23a917038c36c5c84ede704e564335a3ba7fc66"
    end
    on_intel do
      url "https://github.com/bifrost-proxy/bifrost/releases/download/v0.0.194/bifrost-v0.0.194-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "243b890280e659fd1b1bd77f9acb435d765df411cd30b6d53c068af1bb8d2096"
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
