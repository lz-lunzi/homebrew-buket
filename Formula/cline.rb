class Cline < Formula
  desc "Autonomous coding agent CLI by Cline"
  homepage "https://cline.bot"
  version "3.0.68"
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
      sha256 "e203a3905ba7fd6dea88d749e4153e3bd0e5ddbd034bf31c458e3d96078f13b5"
    end
    on_intel do
      url "https://registry.npmjs.org/@cline/cli-darwin-x64/-/cli-darwin-x64-#{version}.tgz",
          using: :nounzip
      sha256 "36b28d60786f5db8d4824dfdd3b1486941e680c2c61428e6a570546120c6fcd9"
    end
  end

  on_linux do
    on_arm do
      url "https://registry.npmjs.org/@cline/cli-linux-arm64/-/cli-linux-arm64-#{version}.tgz",
          using: :nounzip
      sha256 "5e0ad56ba4c494c437f6dcdc2557c165478e05e1800e1fe6f7d476e4fd4c84f2"
    end
    on_intel do
      url "https://registry.npmjs.org/@cline/cli-linux-x64/-/cli-linux-x64-#{version}.tgz",
          using: :nounzip
      sha256 "a979929090eb9a934b3907e2cf519368964d6a35e96079d6db4fc89caad98ab1"
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
