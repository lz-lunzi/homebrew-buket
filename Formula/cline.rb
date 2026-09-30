class Cline < Formula
  desc "Autonomous coding agent CLI by Cline"
  homepage "https://cline.bot"
  version "3.0.66"
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
      sha256 "9eb0bddbdd474107d4b5b42dc0bc454b646d461702ae87893ad6eef6edd17c9b"
    end
    on_intel do
      url "https://registry.npmjs.org/@cline/cli-darwin-x64/-/cli-darwin-x64-#{version}.tgz",
          using: :nounzip
      sha256 "ff110c7e4df4728108c013a7ec00da9b2f23ac3c12f06abe704803253736362d"
    end
  end

  on_linux do
    on_arm do
      url "https://registry.npmjs.org/@cline/cli-linux-arm64/-/cli-linux-arm64-#{version}.tgz",
          using: :nounzip
      sha256 "a2623ce942309b0ff4edc8189c9e399a4c37371409118263f33d3e96bb870442"
    end
    on_intel do
      url "https://registry.npmjs.org/@cline/cli-linux-x64/-/cli-linux-x64-#{version}.tgz",
          using: :nounzip
      sha256 "d7052731de94f40f4e42eddd75407db97615af7813407d12daa31e1eec3ef94b"
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
