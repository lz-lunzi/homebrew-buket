class Octopus < Formula
  desc "LLM API aggregation & load balancing service for individuals"
  homepage "https://github.com/bestruirui/octopus"
  version "0.13.10"
  license "AGPL-3.0-or-later"
  head "https://github.com/bestruirui/octopus.git", branch: "dev"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/bestruirui/octopus/releases/download/v0.13.10/octopus-darwin-arm64.zip"
      sha256 "ab72b742e8ac19bc28b397739520072e3d7e9e3078b188947061563b04f55300"
    end
    on_intel do
      url "https://github.com/bestruirui/octopus/releases/download/v0.13.10/octopus-darwin-amd64.zip"
      sha256 "1add59268506abdb373b8deb7470b83be7f7b18809b8726ad71d09fa5f3d8c92"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bestruirui/octopus/releases/download/v0.13.10/octopus-linux-arm64.zip"
      sha256 "da772345da629ed1278387538da11a037362c1003a820f4b4e5cef636054b304"
    end
    on_intel do
      url "https://github.com/bestruirui/octopus/releases/download/v0.13.10/octopus-linux-amd64.zip"
      sha256 "bb82a81ab8d4a6717cd367155793fecfca8e1310984d807e4af5d2c4224b44ae"
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
