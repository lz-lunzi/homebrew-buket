class TraeCli < Formula
  desc "AI-powered coding assistant for terminal"
  homepage "https://trae.cn"
  version "0.120.27"

  livecheck do
    url :homepage
    regex(/v?(\d+(?:\.\d+)+)/i)
  end

  on_macos do
    on_arm do
      url "https://lf-cdn.trae.com.cn/obj/trae-com-cn/trae-cli/trae-cli_0.120.27_darwin_arm64.tar.gz"
      sha256 "f056aa8f47a2c81174d6dacc0d57ae1bf0873d95aacf0afb58213b49c1ecb279"
    end
    on_intel do
      url "https://lf-cdn.trae.com.cn/obj/trae-com-cn/trae-cli/trae-cli_0.120.27_darwin_amd64.tar.gz"
      sha256 "3e45f2d9d7a2b520fde13fb12c7dc2b80cdd173758b65a8181f007c41eac0147"
    end
  end

  on_linux do
    on_arm do
      url "https://lf-cdn.trae.com.cn/obj/trae-com-cn/trae-cli/trae-cli_0.120.27_linux_arm64.tar.gz"
      sha256 "a02531b6fb110a0c84a80bd43f315684f89c6269c0390593c13b77ca851b1691"
    end
    on_intel do
      url "https://lf-cdn.trae.com.cn/obj/trae-com-cn/trae-cli/trae-cli_0.120.27_linux_amd64.tar.gz"
      sha256 "a83dfefe71c8ba63af82abdc1513d49a053bdeae6932ac76bb11da87594f3580"
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
