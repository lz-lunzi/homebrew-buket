cask "orca" do
  version "1.4.148"

  on_arm do
    url "https://github.com/stablyai/orca/releases/download/v#{version}/orca-macos-arm64.dmg"
    sha256 "205584c78082e5b6d4ea6870e353fe3aac7e0ee3859f914dbde195afb1bce6eb"
  end
  on_intel do
    url "https://github.com/stablyai/orca/releases/download/v#{version}/orca-macos-x64.dmg"
    sha256 "3a67528ef2b31d5512511fa5afb20b05c6787328a707cd96201871cc1f956c6f"
  end

  name "Orca"
  desc "ADE for working with a fleet of parallel AI agents"
  homepage "https://github.com/stablyai/orca"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :big_sur

  app "Orca.app"
end
