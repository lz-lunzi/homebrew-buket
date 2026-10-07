class Cline < Formula
  desc "Autonomous coding agent CLI by Cline"
  homepage "https://cline.bot"
  version "3.0.69"
  license "Apache-2.0"

  # homebrew/core/cline is frozen at 3.0.3 (deprecated: non-FOSS
  # @anthropic-ai/claude-agent-sdk + pre-built binaries). This formula tracks
  # upstream via the platform-specific npm binary packages.
  livecheck do
    url :stable
    regex(/["']latest["']\s*:\s*["']v?(\d+(?:\.\d+)+)["']/i)
    strategy :json do |json, regex|
      match = json["dist-tags"]&.[]("latest")&.match(regex)
      next if match.blank?

      match[1]
    end
  end

  on_macos do
    on_arm do
      url "https://registry.npmjs.org/@cline/cli-darwin-arm64/-/cli-darwin-arm64-#{version}.tgz",
          using: :nounzip
      sha256 "3cd64d4c8918301e4fbd0b4145e84891d94ec081364e8b6ace2bdcdee0e0d5ab"
    end
    on_intel do
      url "https://registry.npmjs.org/@cline/cli-darwin-x64/-/cli-darwin-x64-#{version}.tgz",
          using: :nounzip
      sha256 "39a4772ea87881991d6892eb8994c1044dd845a8825bcfa13e35fd19c4b44782"
    end
  end

  on_linux do
    on_arm do
      url "https://registry.npmjs.org/@cline/cli-linux-arm64/-/cli-linux-arm64-#{version}.tgz",
          using: :nounzip
      sha256 "2e1a5613cc65aa070f64bef4cf8cf218df316249160ba08a60ba74ffbf0c6e56"
    end
    on_intel do
      url "https://registry.npmjs.org/@cline/cli-linux-x64/-/cli-linux-x64-#{version}.tgz",
          using: :nounzip
      sha256 "66965f17f79cca33c9df8777aed65e2bf8c9986198c50a031d0953841fd8e60e"
    end
  end

  # npm tarball (package/bin/cline) is a self-contained Bun-embedded Mach-O/ELF.
  # The webview assets next to it serve `cline hub`; keep them.
  def install
    # nounzip gives us the raw .tgz; unpack it ourselves.
    system "tar", "-xzf", Dir.glob("*.tgz").first
    libexec.install Dir["package/bin/*"], "package/cline-hub" if Dir.exist?("package/cline-hub")
    bin.install libexec/"cline"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cline --version")
  end
end
