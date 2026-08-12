cask "orca" do
  version "1.4.180"

  on_arm do
    sha256 "f8e0ed1299cb2f0af86fcbf318f5cddef35a6b530aacc27b6e264ebec7c3c51f"

    url "https://github.com/stablyai/orca/releases/download/v#{version}/orca-macos-arm64.dmg"
  end
  on_intel do
    sha256 "acc04573514ad85b9f85421fd54eb5f154e06cd27610d0c0985a6159670e8ba1"

    url "https://github.com/stablyai/orca/releases/download/v#{version}/orca-macos-x64.dmg"
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
