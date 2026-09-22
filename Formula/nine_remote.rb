class NineRemote < Formula
  desc "Terminal in Your Pocket - remote access tool for Mac, Linux, and Windows"
  homepage "https://github.com/decolua/9remote"
  url "https://registry.npmjs.org/9remote/-/9remote-3.0.7.tgz"
  sha256 "6de0f5c439e454e86cbe3323a64fb4f9bcc923841a37b481d3fb65356176dd43"
  license "MIT"

  livecheck do
    url "https://registry.npmjs.org/9remote/-/9remote-2.5.8.tgz"
    regex(/"version"\s*:\s*"(\d+(?:\.\d+)+)"/i)
  end

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec.glob("bin/*")
  end

  def caveats
    <<~EOS
      9Remote is a remote access tool - "Terminal in Your Pocket".

      Get started:
        9remote --help

      Visit https://github.com/decolua/9remote for more information.
    EOS
  end

  test do
    assert_match "9remote", shell_output("#{bin}/9remote --version")
  end
end
