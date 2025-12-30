cask "qodercli" do
  version "1.0.0"
  sha256 "1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef"

  url "https://releases.qoder.com/cli/qodercli-#{version}-darwin-arm64.tar.gz"
  name "Qoder CLI"
  desc "Agentic coding platform for terminal-based development"
  homepage "https://qoder.com/cli"

  binary "qodercli", target: "qodercli"

  zap trash: "~/.qoder"
end
