class Crush < Formula
  desc "The glamourous config manager for your app"
  homepage "https://github.com/charmbracelet/crush"
  url "https://github.com/charmbracelet/crush/archive/refs/tags/v0.91.0.tar.gz"
  sha256 "3e558af212a740516187aa851a086b2b0b56ee4f2a726c342d9099a13bbd677e"
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
