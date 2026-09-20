class Octopus < Formula
  desc "LLM API aggregation & load balancing service for individuals"
  homepage "https://github.com/bestruirui/octopus"
  version "0.13.6"
  license "AGPL-3.0-or-later"
  head "https://github.com/bestruirui/octopus.git", branch: "dev"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/bestruirui/octopus/releases/download/v0.13.6/octopus-darwin-arm64.zip"
      sha256 "7f094b4be0e82c33d2ad21e76aa1a54a20352d832b7db8855f2cebb43d365bb1"
    end
    on_intel do
      url "https://github.com/bestruirui/octopus/releases/download/v0.13.6/octopus-darwin-amd64.zip"
      sha256 "a9dd8df8ee92227441b05766a5c6fdf2a7f606c2f9ddf2291bcd11f19a1226cb"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bestruirui/octopus/releases/download/v0.13.6/octopus-linux-arm64.zip"
      sha256 "bb25a6645a913a9d8267e8e6cc840cb574ffb02454ec4ebb574e016c858e5c0c"
    end
    on_intel do
      url "https://github.com/bestruirui/octopus/releases/download/v0.13.6/octopus-linux-amd64.zip"
      sha256 "0d86ed3239083281f8529183fc51304bb526d85d622d40484dbd3402942e42cb"
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
