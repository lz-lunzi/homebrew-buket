class Octopus < Formula
  desc "LLM API aggregation & load balancing service for individuals"
  homepage "https://github.com/bestruirui/octopus"
  version "0.13.5"
  license "AGPL-3.0-or-later"
  head "https://github.com/bestruirui/octopus.git", branch: "dev"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/bestruirui/octopus/releases/download/v0.13.5/octopus-darwin-arm64.zip"
      sha256 "43d89ec85aadd2f9703192be72e2238ede8277976fb44320098577af8a4dec23"
    end
    on_intel do
      url "https://github.com/bestruirui/octopus/releases/download/v0.13.5/octopus-darwin-amd64.zip"
      sha256 "798ad819b053f78bb5e2aad1e9b8d469ca26a6cce9ef0fa1eb6d8f990fac88a9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bestruirui/octopus/releases/download/v0.13.5/octopus-linux-arm64.zip"
      sha256 "50081ee770b2f80632d1a860a64638c9f0f51833f03120dfad89ab1d2bbaf018"
    end
    on_intel do
      url "https://github.com/bestruirui/octopus/releases/download/v0.13.5/octopus-linux-amd64.zip"
      sha256 "f168729206a6d2288b43995fcf573e491715ccaa35ee6097fc3b960ec9ef2e5f"
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
