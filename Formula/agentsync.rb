class Agentsync < Formula
  desc "Infrastructure layer for AI coding agent configuration management"
  homepage "https://github.com/dallay/agentsync"
  url "https://registry.npmjs.org/agentsync/-/agentsync-0.2.0-alpha.23.tgz"
  version "0.2.0-alpha.23"
  sha256 "1b0ba5aabc21eaa6e86c8e4a5cbae1eb8a4ae0d204afbe958e76423f71cbb1db"
  license "MIT"

  livecheck do
    url "https://registry.npmjs.org/agentsync/latest"
    regex(/"version"\s*:\s*"([\d.]+(?:-[\w.]+)?)"/i)
  end

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec.glob("bin/*")
  end

  def caveats
    <<~EOS
      AgentSync - Infrastructure for AI coding agent configuration management.

      Get started:
        agentsync --help

      Visit https://github.com/dallay/agentsync for more information.
    EOS
  end

  test do
    assert_match "agentsync", shell_output("#{bin}/agentsync --version")
  end
end
