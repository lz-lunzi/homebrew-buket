class Orca < Formula
  desc "ADE for working with a fleet of parallel AI agents"
  homepage "https://github.com/stablyai/orca"
  version "1.4.149"
  license "MIT"

  livecheck do
    url "https://github.com/stablyai/orca/releases/latest"
    strategy :github_latest
  end

  on_linux do
    on_arm do
      url "https://github.com/stablyai/orca/releases/download/v#{version}/orca-ide_#{version}_arm64.deb"
      sha256 "fbd792c155064a64d3fe3b015b908e4fa367c7374f9a194f8eaddfe8fe82521d"
    end
    on_intel do
      url "https://github.com/stablyai/orca/releases/download/v#{version}/orca-ide_#{version}_amd64.deb"
      sha256 "ecec2fe903e29afd8dea52db68f5a4db28eef077e9aa478061df5a2fdaead521"
    end
  end

  def install
    deb = Dir["*.deb"].first
    system "ar", "x", deb
    system "tar", "xf", "data.tar.xz"
    libexec.install "opt/Orca"
    (bin/"orca").write <<~BASH
      #!/bin/bash
      exec "#{libexec}/Orca/orca-ide" "$@"
    BASH
  end

  test do
    system bin/"orca", "--version"
  end
end
