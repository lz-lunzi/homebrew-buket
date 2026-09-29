class Crush < Formula
  desc "The glamourous config manager for your app"
  homepage "https://github.com/charmbracelet/crush"
  url "https://github.com/charmbracelet/crush/archive/refs/tags/v0.97.1.tar.gz"
  sha256 "2d008a034c3e7351937e69f4b21ac653e4e0ae2e1fb0fe11b8d37a3094c15d9e"
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
