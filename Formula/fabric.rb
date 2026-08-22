class Fabric < Formula
  desc "AI tool for augmenting humans using AI"
  homepage "https://github.com/danielmiessler/Fabric"
  url "https://github.com/danielmiessler/Fabric/archive/refs/tags/v1.4.100.tar.gz"
  sha256 "0f073a32c390e50c2e00a6f06210b32ebd9151010a38ad10227e23284ef16fab"
  license "MIT"
  head "https://github.com/danielmiessler/Fabric.git", branch: "main"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w"), "./cmd/fabric"
  end

  test do
    system bin/"fabric", "--version"
  end
end
