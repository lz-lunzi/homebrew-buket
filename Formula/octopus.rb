class Octopus < Formula
  desc "LLM API aggregation & load balancing service for individuals"
  homepage "https://github.com/bestruirui/octopus"
  version "0.13.8"
  license "AGPL-3.0-or-later"
  head "https://github.com/bestruirui/octopus.git", branch: "dev"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/bestruirui/octopus/releases/download/v0.13.8/octopus-darwin-arm64.zip"
      sha256 "424349d59e69993b1b9611f11e962369e1905a93ad1f63c6d849a7307888e44b"
    end
    on_intel do
      url "https://github.com/bestruirui/octopus/releases/download/v0.13.8/octopus-darwin-amd64.zip"
      sha256 "fa0540794c2f29df25da1141697feb9ca69e570525dd911fbf2d3a01e2ced224"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bestruirui/octopus/releases/download/v0.13.8/octopus-linux-arm64.zip"
      sha256 "43005de46a78db5eb4f7693090ea9a9abf6eb23af21baac3f3a0fe3f1ea18097"
    end
    on_intel do
      url "https://github.com/bestruirui/octopus/releases/download/v0.13.8/octopus-linux-amd64.zip"
      sha256 "5cbaafc035dbee86724df83e431d0f06c32180a80718d50d8bdaf964e7734a14"
    end
  end

  def install
    bin.install "octopus"
  end

  service do
    run [opt_bin/"octopus", "start"]
    keep_alive true
    working_dir var
    log_path var/"log/octopus.log"
    error_log_path var/"log/octopus.log"
  end

  def caveats
    <<~EOS
      Octopus is an LLM API aggregation and load balancing service.

      Default credentials (please change after first login):
        Username: admin
        Password: admin

      To start the service:
        octopus start

      Or use Homebrew services:
        brew services start octopus

      Access the web UI at: http://localhost:8080

      For more information, visit: https://github.com/bestruirui/octopus
    EOS
  end

  test do
    assert_match "octopus version #{version}", shell_output("#{bin}/octopus version", 1)
  end
end
