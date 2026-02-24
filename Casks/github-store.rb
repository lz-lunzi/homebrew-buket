cask "github-store" do
  version "1.5.1"
  sha256 :no_check

  on_arm do
    url "https://github.com/rainxchzed/Github-Store/releases/download/#{version}/GitHub.Store-#{version}_arm64.dmg",
        verified: "github.com/rainxchzed/Github-Store/"
  end
  on_intel do
    url "https://github.com/rainxchzed/Github-Store/releases/download/#{version}/Github.Store-#{version}_x64.dmg",
        verified: "github.com/rainxchzed/Github-Store/"
  end

  name "GitHub Store"
  desc "Free, open-source app store for GitHub releases with one-click installation"
  homepage "https://www.github-store.org/"

  app "GitHub Store.app"

  caveats <<~EOS
    GitHub Store is a cross-platform app store for GitHub releases that provides:
    - Smart discovery of trending, recently updated, and new projects
    - One-click installation from latest GitHub releases
    - Automatic platform detection (APK, EXE, DMG, AppImage, DEB, RPM)
    - Update tracking for installed apps
    - Rich repository details with rendered README content

    Note: macOS may show a warning that Apple cannot verify GitHub Store.
    Allow it via System Settings → Privacy & Security → Open Anyway.

    Visit https://www.github-store.org for more information.
  EOS
end
