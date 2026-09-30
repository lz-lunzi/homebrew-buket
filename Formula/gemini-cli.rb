class GeminiCli < Formula
  desc "Google Gemini CLI"
  homepage "https://github.com/google-gemini/gemini-cli"

  deprecate! date: "2026-09-01", because: "moved to homebrew/core", replacement_formula: "gemini-cli"
  disable! date: "2027-09-01", because: "moved to homebrew/core", replacement_formula: "gemini-cli"

  url "https://registry.npmjs.org/@google/gemini-cli/-/gemini-cli-0.62.0.tgz"
  sha256 "2276032b1c33d2b828b1cf197e52f48e74b0a395326763ff01a80d97d0fbc0c3"
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
