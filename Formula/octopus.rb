class Octopus < Formula
  desc "LLM API aggregation & load balancing service for individuals"
  homepage "https://github.com/bestruirui/octopus"
  version "0.13.9"
  license "AGPL-3.0-or-later"
  head "https://github.com/bestruirui/octopus.git", branch: "dev"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/bestruirui/octopus/releases/download/v0.13.9/octopus-darwin-arm64.zip"
      sha256 "f260d946e37f31e4cb11a817bfead97e0172ffd7b228ab34fa2b48dc4c939618"
    end
    on_intel do
      url "https://github.com/bestruirui/octopus/releases/download/v0.13.9/octopus-darwin-amd64.zip"
      sha256 "d3482720814f8ab5b0bb925d37355d583956d1b87a4d543692991cc0653702bd"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bestruirui/octopus/releases/download/v0.13.9/octopus-linux-arm64.zip"
      sha256 "483d1db2b26b061f109e7ae81fbd5ba68fbd5bc8fbe952427f448424f6deeeec"
    end
    on_intel do
      url "https://github.com/bestruirui/octopus/releases/download/v0.13.9/octopus-linux-amd64.zip"
      sha256 "50c646ee522fc16c43370eb5390831c01577ebfc325ee44a6384378db81d098c"
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
