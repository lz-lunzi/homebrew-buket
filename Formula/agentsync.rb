class Agentsync < Formula
  desc "Infrastructure layer for AI coding agent configuration management"
  homepage "https://github.com/dallay/agentsync"
  url "https://registry.npmjs.org/agentsync/-/agentsync-1.0.0.tgz"
  sha256 "17474fbd3bf45ecbe560ebe91cef209b8637bd5bece429f0d45268dc8cc61c0a"
  license "MIT"

  livecheck do
    url "https://registry.npmjs.org/agentsync/-/agentsync-0.2.0-alpha.23.tgz"
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
