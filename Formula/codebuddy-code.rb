class CodebuddyCode < Formula
  desc "Use CodeBuddy, Tencent's AI assistant, right from your terminal"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  url "https://registry.npmjs.org/@tencent-ai/codebuddy-code/-/codebuddy-code-2.164.0.tgz"
  sha256 "6d6f594e890a533cc8f635110e27e79e82e039a796703a7265a117cbab0281ed"
  license "MIT"

  livecheck do
    url "https://registry.npmjs.org/@tencent-ai/codebuddy-code/-/codebuddy-code-2.160.0.tgz"
    regex(/"version"\s*:\s*"(\d+(?:\.\d+)+)"/i)
  end

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec.glob("bin/*")
  end

  def caveats
    <<~EOS
      CodeBuddy Code is Tencent's AI assistant for terminal-based development.

      Available commands:
        cbc          - Short alias for codebuddy
        codebuddy    - Main command

      Get started:
        codebuddy --help
        cbc --help

      Visit https://cnb.cool/codebuddy/codebuddy-code for more information.
    EOS
  end

  test do
    assert_match "codebuddy", shell_output("#{bin}/codebuddy --version")
  end
end
