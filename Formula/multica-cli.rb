class MulticaCli < Formula
  desc "Multica CLI — local agent runtime and management tool for the Multica platform"
  homepage "https://github.com/multica-ai/multica"
  license "Apache-2.0"
  version "0.4.34"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/multica-ai/multica/releases/download/v#{version}/multica-cli-#{version}-darwin-arm64.tar.gz"
      sha256 "65e16595e3b3c45fb57424cb76b7b35e22f0e1a63a205b02cedb8a2473539250"
    end
    on_intel do
      url "https://github.com/multica-ai/multica/releases/download/v#{version}/multica-cli-#{version}-darwin-amd64.tar.gz"
      sha256 "513b7cd2dc348358c7205e5b4d031f70029503a9b786c893c81086c9105168fe"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/multica-ai/multica/releases/download/v#{version}/multica-cli-#{version}-linux-arm64.tar.gz"
      sha256 "7a3d27441e2e964a30e3768fd7e61afdb84f815b61f2a98ef22cd2cfb83fffe7"
    end
    on_intel do
      url "https://github.com/multica-ai/multica/releases/download/v#{version}/multica-cli-#{version}-linux-amd64.tar.gz"
      sha256 "14f8f463cdf2b2adbad5cc7cbe3902a03cecf605f2f52b8f148cc0dc502e98db"
    end
  end

  def install
    bin.install "multica"
  end

  test do
    assert_match "multica", shell_output("#{bin}/multica version")
  end
end
