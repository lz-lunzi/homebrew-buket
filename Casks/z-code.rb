cask "z-code" do
  version "0.11.1"
  sha256 "0cee980de978625430904a1ae70b1ad2695119a2be9b3d86ce756e9bd91e396c"

  url "https://cdn.zcode-ai.com/zcode/releases/0.11.1/z-code_0.11.1_aarch64.dmg"
  name "Z Code"
  desc "AI-powered coding platform with context-aware agents"
  homepage "https://zcode-ai.com/cn"

  app "Z Code.app"

  caveats <<~EOS
    Z Code is currently in alpha testing.
    Visit https://zcode-ai.com/cn for more information.
  EOS

  livecheck do
    skip "No public version information available"
  end
end
