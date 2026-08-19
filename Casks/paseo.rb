cask "paseo" do
  version "0.4.0"

  on_macos do
    on_arm do
      sha256 "bb754306f13019038d8d03a998357e2c6aef96093f69b4ea3cb43f66d4f33462"

      url "https://github.com/getpaseo/paseo/releases/download/v#{version}/Paseo-#{version}-arm64.dmg"
    end
    on_intel do
      sha256 "0c90a8878adff517b93031f019ab0ff55f1cad9fb5732b8c6efdc03c347680cc"

      url "https://github.com/getpaseo/paseo/releases/download/v#{version}/Paseo-#{version}-x64.dmg"
    end
  end

  on_linux do
    sha256 "73bffb4644f6eb957c1050e8436a442e6cae1b44e556fc7f6983bec49ba11075"

    url "https://github.com/getpaseo/paseo/releases/download/v#{version}/Paseo-x86_64.AppImage"
  end

  name "Paseo"
  desc "Orchestrate multiple coding agents from desktop and mobile"
  homepage "https://paseo.sh"

  livecheck do
    url :url
    strategy :github_latest
  end

  on_macos do
    depends_on macos: ">= :big_sur"
    app "Paseo.app"
  end

  on_linux do
    app_image "Paseo-x86_64.AppImage"
  end
end
