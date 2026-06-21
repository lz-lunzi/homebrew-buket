cask "otty" do
  version :latest
  sha256 :no_check

  url "https://downloads.otty.sh/macos/Otty.dmg"
  name "Otty"
  desc "Desktop terminal with AI integration"
  homepage "https://otty.sh"

  depends_on macos: ">= :big_sur"

  app "Otty.app"
end
