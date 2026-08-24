class TraeCli < Formula
  desc "AI-powered coding assistant for terminal"
  homepage "https://trae.cn"
  license "MIT"

  livecheck do
    url "https://lf-cdn.trae.com.cn/obj/trae-com-cn/trae-cli/trae-cli_latest_version.txt"
    regex(/v?(\d+(?:\.\d+)+)/i)
  end

  on_macos do
    on_arm do
      url "https://lf-cdn.trae.com.cn/obj/trae-com-cn/trae-cli/trae-cli_0.120.52_darwin_arm64.tar.gz"
      sha256 "3bd7f60b68c38b847120ab63955f81907f34dab5f34377a9faf0c1fb04b055fd"
    end
  end

  on_linux do
    on_intel do
      url "https://lf-cdn.trae.com.cn/obj/trae-com-cn/trae-cli/trae-cli_0.120.52_linux_amd64.tar.gz"
      sha256 "b92505d7ebfe1956387f4c9368bc66cfbdeb3b5e81ce773e2b0cbca2fb3e4c39"
    end
  end

  def install
    bin.install "trae-cli"
    bin.install_symlink bin/"trae-cli" => "traecli"
    bin.install_symlink bin/"trae-cli" => "trae-agent"
    bin.install_symlink bin/"trae-cli" => "ta"
  end

  def caveats
    <<~EOS
      Trae CLI - AI-powered coding assistant for terminal.

      Available commands:
        trae-cli     - Main command
        traecli      - Alias
        trae-agent   - Alias
        ta           - Short alias

      Get started:
        trae-cli --help

      Visit https://trae.cn for more information.
    EOS
  end

  test do
    assert_match "trae-cli", shell_output("#{bin}/trae-cli --version")
  end
end
