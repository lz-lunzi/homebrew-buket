class MulticaCli < Formula
  desc "Multica CLI — local agent runtime and management tool for the Multica platform"
  homepage "https://github.com/multica-ai/multica"
  license "Apache-2.0"
  version "0.4.38"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/multica-ai/multica/releases/download/v0.4.38/multica-cli-0.4.38-darwin-arm64.tar.gz"
      sha256 "be6cbbdcfaf3b6a0544625f9f96127230d81b54ae973d4582429a36aea8a26a1"
    end
    on_intel do
      url "https://github.com/multica-ai/multica/releases/download/v0.4.38/multica-cli-0.4.38-darwin-amd64.tar.gz"
      sha256 "257cd81e44938689b47934d3b0c3bed2fe8327d9e0928470106daaf0c59e3877"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/multica-ai/multica/releases/download/v0.4.38/multica-cli-0.4.38-linux-arm64.tar.gz"
      sha256 "c40e84facfc371390072335b682c697ee32b0ecd949da70e0b2d0943250cf064"
    end
    on_intel do
      url "https://github.com/multica-ai/multica/releases/download/v0.4.38/multica-cli-0.4.38-linux-amd64.tar.gz"
      sha256 "55f494ba058108f0fc3d684d711484fda9e0abafc61ceab06666dcbb5d4c6062"
    end
  end

  def install
    bin.install "multica"
  end

  test do
    assert_match "multica", shell_output("#{bin}/multica version")
  end
end
