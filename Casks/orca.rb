cask "orca" do
  version "1.4.149"

  on_arm do
    sha256 "7a2442ca9207f520b69ebee3c94306639ed1bf162225452cf48ce50025d074e9"

    url "https://github.com/stablyai/orca/releases/download/v#{version}/orca-macos-arm64.dmg"
  end
  on_intel do
    sha256 "ae7a58ce945e5ae5f7ff73c689a886e1631e4c0bfb5401ce0d6af232cf03884b"

    url "https://github.com/stablyai/orca/releases/download/v#{version}/orca-macos-x64.dmg"
  end

  name "Orca"
  desc "ADE for working with a fleet of parallel AI agents"
  homepage "https://github.com/stablyai/orca"

  livecheck do
    url :url
    strategy :github_latest
  end

  deprecate! date: "2026-07-22", because: "moved to homebrew/cask", replacement_cask: "orca"
  disable! date: "2027-07-22", because: "moved to homebrew/cask", replacement_cask: "orca"

  depends_on macos: :big_sur

  app "Orca.app"
end
