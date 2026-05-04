class Litellm < Formula
  include Language::Python::Virtualenv

  desc "Library to easily interface with LLM API providers"
  homepage "https://github.com/BerriAI/litellm"
  url "https://files.pythonhosted.org/packages/source/l/litellm/litellm-1.83.14.tar.gz"
  sha256 "24aef9b47cdc424c833e32f3727f411741c690832cd1fe4405e0077144fe09c9"
  license "MIT"
  head "https://github.com/BerriAI/litellm.git", branch: "main"

  depends_on "python@3.11"

  def install
    virtualenv_install_with_resources
  end

  def caveats
    <<~EOS
      LiteLLM is a library to easily interface with LLM API providers.

      It can be used in two ways:
      1. Python SDK - import litellm in your Python code
      2. Proxy Server - run litellm as a standalone server

      Quick start:
        # As Python SDK
        import litellm
        response = litellm.completion(model="gpt-3.5-turbo", messages=[{"role": "user", "content": "Hello!"}])

        # As Proxy Server
        litellm --model gpt-3.5-turbo

      For more information, visit: https://docs.litellm.ai
    EOS
  end

  test do
    system bin/"python", "-c", "import litellm; print(litellm.__version__)"
  end

  livecheck do
    url "https://pypi.org/pypi/litellm/json"
    regex(/"version"\s*:\s*"(\d+(?:\.\d+)+)"/)
  end
end
