cask "removemacai" do
  version "1.0.3"
  sha256 "adb7b8b0f16f6704b976f55f715f89b965fad7f4e09d358de5d28a37bfad8250"

  url "https://github.com/omlahore/RemoveMacAI/releases/download/v#{version}/RemoveMacAI.zip"
  name "RemoveMacAI"
  desc "Turn off Apple Intelligence, analytics, ads and pop-ups"
  homepage "https://github.com/omlahore/RemoveMacAI"

  livecheck do
    url "https://github.com/omlahore/RemoveMacAI/releases"
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :golden_gate

  app "RemoveMacAI.app"
end
