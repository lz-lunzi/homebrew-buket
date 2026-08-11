class Orca < Formula
  desc "ADE for working with a fleet of parallel AI agents"
  homepage "https://github.com/stablyai/orca"
  version "1.4.180"
  license "MIT"

  livecheck do
    url "https://github.com/stablyai/orca/releases/latest"
    strategy :github_latest
  end

  url "https://github.com/stablyai/orca/releases/download/v#{version}/orca-ide_#{version}_amd64.deb"
  sha256 "fc8b129e4deda381ed6f18e2cc8a970b81550bbe248b93cf8d04ee4e5bd252d8"

  on_linux do
    on_arm do
      url "https://github.com/stablyai/orca/releases/download/v#{version}/orca-ide_#{version}_arm64.deb"
      sha256 "c7f5b648f62b4e8d5b52cf990812d292c1efb22d115ab51a00153e0a673abacd"
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
