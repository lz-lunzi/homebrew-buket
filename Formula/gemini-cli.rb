class GeminiCli < Formula
  desc "Google Gemini CLI"
  homepage "https://github.com/google-gemini/gemini-cli"

  deprecate! date: "2026-09-01", because: "moved to homebrew/core", replacement_formula: "gemini-cli"
  disable! date: "2027-09-01", because: "moved to homebrew/core", replacement_formula: "gemini-cli"

  url "https://registry.npmjs.org/@google/gemini-cli/-/gemini-cli-0.56.0.tgz"
  sha256 "e25443a59b22f0000d6418ce42c5c0710bc04d8f41b5567417e30e038a80120b"
  license "Apache-2.0"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec.glob("bin/*")
  end

  test do
    system bin/"gemini", "--version"
  end
end
