class CodebuddyCode < Formula
  desc "Use CodeBuddy, Tencent's AI assistant, right from your terminal"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  url "https://registry.npmjs.org/@tencent-ai/codebuddy-code/-/codebuddy-code-2.154.0.tgz"
  sha256 "b39caeecdc186e830b55fdf4462ddc4b46c7e7941e51278859dd25e7fdb75f90"
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
