class Octopus < Formula
  desc "LLM API aggregation & load balancing service for individuals"
  homepage "https://github.com/bestruirui/octopus"
  version "0.9.24"
  license "AGPL-3.0"
  head "https://github.com/bestruirui/octopus.git", branch: "dev"

  on_macos do
    on_arm do
      url "https://github.com/bestruirui/octopus/releases/download/v#{version}/octopus-darwin-arm64.zip"
      sha256 "f4fbd8f290c231b1d10647c772f9ebf724331728bbca3b0e7883d6d3ee8bf040"
    end
    on_intel do
      url "https://github.com/bestruirui/octopus/releases/download/v#{version}/octopus-darwin-x86_64.zip"
      sha256 "a99bdcbb7981229e111418d9b20671fee97d0a1f4db406dcbad000caa7a9a093"
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
