class Octopus < Formula
  desc "LLM API aggregation & load balancing service for individuals"
  homepage "https://github.com/bestruirui/octopus"
  version "0.13.2"
  license "AGPL-3.0-or-later"
  head "https://github.com/bestruirui/octopus.git", branch: "dev"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/bestruirui/octopus/releases/download/v0.13.2/octopus-darwin-arm64.zip"
      sha256 "bdf046d27371c5886f7f0018fdccdfd602cbf331311c6a4eb44ecff07ab07b44"
    end
    on_intel do
      url "https://github.com/bestruirui/octopus/releases/download/v0.13.2/octopus-darwin-amd64.zip"
      sha256 "6ade5f52e762dc9086ba7fe06d53237595d93372200c767f2aecd9c16989fe96"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bestruirui/octopus/releases/download/v0.13.2/octopus-linux-arm64.zip"
      sha256 "b2755f49d26187ca52fd62ba32bd259c11f456fec858baf6bc5b97f143f7fb3d"
    end
    on_intel do
      url "https://github.com/bestruirui/octopus/releases/download/v0.13.2/octopus-linux-amd64.zip"
      sha256 "30247b2a53856671a333da57236cdef91550a79eb5871c13e883168ff438edab"
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
