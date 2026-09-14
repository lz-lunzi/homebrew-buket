class Crush < Formula
  desc "The glamourous config manager for your app"
  homepage "https://github.com/charmbracelet/crush"
  url "https://github.com/charmbracelet/crush/archive/refs/tags/v0.94.2.tar.gz"
  sha256 "56aeb876655d01c793a45a7dd5a683815ec9e8ba56e149779f6c788d127c4173"
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
