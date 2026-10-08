class Cline < Formula
  desc "Autonomous coding agent CLI by Cline"
  homepage "https://cline.bot"
  version "3.0.70"
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
      sha256 "ebdfcc7c59e209a6ff0b12631dad0cdeb40dba8d927e5d580e1962d65114277b"
    end
    on_intel do
      url "https://registry.npmjs.org/@cline/cli-darwin-x64/-/cli-darwin-x64-#{version}.tgz",
          using: :nounzip
      sha256 "6258d1f32a63c7df494c670f0ab4888571168b7ca4c6b5957ab0284879db2e21"
    end
  end

  on_linux do
    on_arm do
      url "https://registry.npmjs.org/@cline/cli-linux-arm64/-/cli-linux-arm64-#{version}.tgz",
          using: :nounzip
      sha256 "7b0d06eee33970e20a8da9fa63d4674591ff10572a427489b0e5b3b1528cdc4f"
    end
    on_intel do
      url "https://registry.npmjs.org/@cline/cli-linux-x64/-/cli-linux-x64-#{version}.tgz",
          using: :nounzip
      sha256 "5a865281d6a2de05a96e663ad94aa6672f5817b60a9844e57f42c4c50365a6a3"
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
