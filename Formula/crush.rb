class Crush < Formula
  desc "The glamourous config manager for your app"
  homepage "https://github.com/charmbracelet/crush"
  url "https://github.com/charmbracelet/crush/archive/refs/tags/v0.96.1.tar.gz"
  sha256 "5a71fae5374ba86115344287edb45ccd8ed4c89406829d5d3fb9ef44e19900df"
  license "MIT"
  head "https://github.com/charmbracelet/crush.git", branch: "main"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w")
  end

  test do
    system bin/"crush", "--version"
  end
end
