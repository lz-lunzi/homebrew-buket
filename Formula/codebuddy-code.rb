class CodebuddyCode < Formula
  desc "Use CodeBuddy, Tencent's AI assistant, right from your terminal"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  url "https://registry.npmjs.org/@tencent-ai/codebuddy-code/-/codebuddy-code-2.95.0.tgz"
  sha256 "0f4b607ee6529bf6c0c1cf0ced5201a5ec81b57cf51fe9ad3dbe6138dd3533f0"
  license "MIT"
  version "2.95.0"

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

  livecheck do
    url "https://registry.npmjs.org/@tencent-ai/codebuddy-code/latest"
    regex(/"version"\s*:\s*"(\d+(?:\.\d+)+)"/)
  end
end
