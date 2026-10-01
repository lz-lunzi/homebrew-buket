class Cline < Formula
  desc "Autonomous coding agent CLI by Cline"
  homepage "https://cline.bot"
  version "3.0.67"
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
      sha256 "ddd190374b941e733a003f28654b5f801299f848431bad3bb0772cf995a3aec3"
    end
    on_intel do
      url "https://registry.npmjs.org/@cline/cli-darwin-x64/-/cli-darwin-x64-#{version}.tgz",
          using: :nounzip
      sha256 "e9a1487029efa0b03a1b99d7e931a18ab2873e86d8c264e70c7a4d164a843c84"
    end
  end

  on_linux do
    on_arm do
      url "https://registry.npmjs.org/@cline/cli-linux-arm64/-/cli-linux-arm64-#{version}.tgz",
          using: :nounzip
      sha256 "c1b34ea3d356619d7d57c6dd1099296d746332673011341abe0011e05a08ccb9"
    end
    on_intel do
      url "https://registry.npmjs.org/@cline/cli-linux-x64/-/cli-linux-x64-#{version}.tgz",
          using: :nounzip
      sha256 "ada74eac8b0a71a9b09390b7b06dd4942260a63e8861cd9e27085e7e084d41ed"
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
