class AgentS < Formula
  include Language::Python::Virtualenv

  desc "Open-source agentic framework that uses computers like humans"
  homepage "https://github.com/simular-ai/Agent-S"
  url "https://files.pythonhosted.org/packages/5a/b2/8082453e0c4689f8ed348b6c7fc246fd0844f63f82d17b784aa2a38b6947/gui_agents-0.3.2-py3-none-any.whl"
  sha256 "bd089217dd50acb698794efc43e7df60f11091efa5e30d695bc2ef72e8cdc027"
  license "Apache-2.0"

  depends_on "python@3.12"

  def install
    virtualenv_install_with_resources
  end

  test do
    system python3, "-c", "import agent_s"
  end
end
