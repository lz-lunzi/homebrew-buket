class Octopus < Formula
  desc "LLM API aggregation & load balancing service for individuals"
  homepage "https://github.com/bestruirui/octopus"
  version "0.12.1"
  license "AGPL-3.0-or-later"
  head "https://github.com/bestruirui/octopus.git", branch: "dev"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/bestruirui/octopus/releases/download/v0.12.1/octopus-darwin-arm64.zip"
      sha256 "1f56056d345a5c56b3851c9cca08e54708b137ea8e4ac676bc0a40dc7b52fb09"
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
