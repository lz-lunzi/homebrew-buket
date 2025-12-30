cask "z-code" do
  version "0.11.1"
  sha256 "placeholder_sha256_replace_with_actual_value"

  url "https://cdn.zcode-ai.com/zcode/releases/#{version}/z-code_#{version}_aarch64.dmg"
  name "Z Code"
  desc "AI-powered coding platform with context-aware agents"
  homepage "https://zcode-ai.com/cn"

  app "Z Code.app"

  caveats <<~EOS
    Z Code is currently in alpha testing.
    Visit https://zcode-ai.com/cn for more information.
  EOS
end
