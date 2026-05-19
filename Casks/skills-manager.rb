cask "skills-manager" do
  version "1.3.3"
  sha256 :no_check

  on_arm do
    url "https://github.com/cchao123/skills-manager/releases/download/v#{version}/Skills-Manager-macOS-arm64-v#{version}.dmg"
  end
  on_intel do
    url "https://github.com/cchao123/skills-manager/releases/download/v#{version}/Skills-Manager-macOS-x64-v#{version}.dmg"
  end

  name "Skills Manager"
  desc "Package manager for AI agent skills with cross-agent sharing and deployment"
  homepage "https://github.com/cchao123/skills-manager"

  livecheck do
    url "https://github.com/cchao123/skills-manager/releases"
    strategy :github_latest
  end

  depends_on macos: :big_sur

  app "Skills Manager.app"

  caveats <<~EOS
    Skills Manager - Package manager for AI agent skills.

    Features:
    - Cross-agent skill sharing and deployment
    - Sync skills across multiple AI coding agents
    - One-click skill installation and management

    Docs: https://github.com/cchao123/skills-manager
  EOS
end
