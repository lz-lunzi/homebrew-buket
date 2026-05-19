cask "skills-manage" do
  version "0.10.0"
  sha256 :no_check

  url "https://github.com/iamzhihuix/skills-manage/releases/download/v#{version}/skills-manage_#{version}_macos_universal.dmg"
  name "Skills Manage"
  desc "Manage AI coding agent skills across 20+ platforms from one place"
  homepage "https://github.com/iamzhihuix/skills-manage"

  livecheck do
    url "https://github.com/iamzhihuix/skills-manage/releases"
    strategy :github_latest
  end

  depends_on macos: :big_sur

  app "skills-manage.app"

  caveats <<~EOS
    Skills Manage - Manage AI coding agent skills from one place.

    Supported platforms:
    - Claude Code, Cursor, Gemini CLI, Codex
    - 20+ AI coding platforms

    Docs: https://github.com/iamzhihuix/skills-manage
  EOS
end
