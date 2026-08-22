class Serena < Formula
  include Language::Python::Virtualenv

  desc "Coding agent toolkit providing semantic code retrieval and editing"
  homepage "https://oraios.github.io/serena"
  url "https://github.com/oraios/serena/releases/download/v1.3.0/serena_agent-1.3.0-py3-none-any.whl"
  sha256 "1e2977e349eb9468f7be72ffa65eb3c83923a12cf2a2185a3ec2f581e411a6d9"
  license "MIT"

  depends_on "python@3.12"

  def install
    virtualenv_install_with_resources
  end

  test do
    system python3, "-c", "import serena"
  end
end
