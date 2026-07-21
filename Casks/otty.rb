cask "otty" do
  version :latest
  sha256 :no_check

  url "https://downloads.otty.sh/macos/Otty.dmg"
  name "Otty"
  desc "Desktop terminal with AI integration"
  homepage "https://otty.sh/"

  deprecate! date: "2026-07-21", because: "moved to homebrew/cask", replacement_cask: "otty"
  disable! date: "2027-01-21", because: "moved to homebrew/cask", replacement_cask: "otty"

  depends_on macos: :big_sur

  app "Otty.app"
end
