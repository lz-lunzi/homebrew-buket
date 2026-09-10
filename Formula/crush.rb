class Crush < Formula
  desc "The glamourous config manager for your app"
  homepage "https://github.com/charmbracelet/crush"
  url "https://github.com/charmbracelet/crush/archive/refs/tags/v0.93.1.tar.gz"
  sha256 "4db10215af816554915158e52b75ab720f459b21ce7d3dad399be332bfedd459"
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
