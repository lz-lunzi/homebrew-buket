class Orca < Formula
  desc "ADE for working with a fleet of parallel AI agents"
  homepage "https://github.com/stablyai/orca"
  version "1.4.184"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/stablyai/orca/releases/download/v#{version}/Orca-#{version}-arm64-mac.zip"
      sha256 "4d67b51a2b0c98346e4f7189b1acc15caa860d6854ec10c68c45347b93cec5ac"
    end
    on_intel do
      url "https://github.com/stablyai/orca/releases/download/v#{version}/Orca-#{version}-mac.zip"
      sha256 "94274bb2935916108ec97eee5c0f998d2607e47e8622ed1757a87fb6e7f20a08"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/stablyai/orca/releases/download/v#{version}/orca-linux.AppImage"
      sha256 "c1eef835427d0d50ac182426b128b02117cc4043a63bf03e83ee5578943f4fa8"
    end
    on_arm do
      url "https://github.com/stablyai/orca/releases/download/v#{version}/orca-linux-arm64.AppImage"
      sha256 "767adf1a4992232356a4366ed4b6b16872a998ec1a787dfb633efb366e46746f"
    end
  end

  def install
    if OS.mac?
      prefix.install "Orca.app"
      bin.install_symlink prefix/"Orca.app/Contents/MacOS/Orca" => "orca"
    else
      appimage = Dir["orca-linux*.AppImage"].first
      libexec.install appimage
      chmod 0755, libexec/appimage
      (bin/"orca").write <<~BASH
        #!/bin/bash
        export APPIMAGE_EXTRACT_AND_RUN=1
        exec "#{libexec}/#{appimage}" "$@"
      BASH
      chmod 0755, bin/"orca"
    end
  end

  def caveats
    <<~EOS
      Orca — ADE for working with a fleet of parallel AI agents.

      macOS: GUI app installed at #{prefix}/Orca.app.
        CLI: orca

      Linux: AppImage bundled at #{libexec}.
        CLI: orca

      Docs: https://github.com/stablyai/orca
    EOS
  end

  test do
    system bin/"orca", "--version"
  end
end
