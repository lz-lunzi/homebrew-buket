class CodebuddyCode < Formula
  desc "Use CodeBuddy, Tencent's AI assistant, right from your terminal"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  url "https://registry.npmjs.org/@tencent-ai/codebuddy-code/-/codebuddy-code-2.143.1.tgz"
  sha256 "8adf925f8609d87d88caa4473aec54e439b4e240cbcc749d00f18115a39ec9f2"
  license "MIT"

  livecheck do
    url "https://registry.npmjs.org/@tencent-ai/codebuddy-code/-/codebuddy-code-2.137.1.tgz"
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
