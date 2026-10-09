cask "removemacai" do
  version "1.0.2"
  sha256 "ec351378a053e047159b8432cd05c3c53fa273eef23d3b50cefd4ab74697cdfc"

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
