class Litellm < Formula
  include Language::Python::Virtualenv

  desc "Library to easily interface with LLM API providers"
  homepage "https://github.com/BerriAI/litellm"
  url "https://files.pythonhosted.org/packages/source/l/litellm/litellm-1.83.14.tar.gz"
  sha256 "24aef9b47cdc424c833e32f3727f411741c690832cd1fe4405e0077144fe09c9"
  license "MIT"
  head "https://github.com/BerriAI/litellm.git", branch: "main"

  depends_on "python@3.11"
  depends_on "rust" => :build

  def install
    virtualenv_install_with_resources

    # 创建配置目录
    (etc/"litellm").mkpath

    # 写入默认配置文件
    config_content = <<~YAML
      # LiteLLM Proxy Configuration
      # 配置文件位置: #{etc}/litellm/config.yaml
      # 文档: https://docs.litellm.ai/docs/proxy/configs

      model_list:
        # 默认模型配置 - 修改 api_base 为你的后端服务地址
        - model_name: gpt-4
          litellm_params:
            model: openai/gpt-4
            api_base: http://127.0.0.1:23333/v1
            api_key: sk-your-api-key-here

        - model_name: gpt-3.5-turbo
          litellm_params:
            model: openai/gpt-3.5-turbo
            api_base: http://127.0.0.1:23333/v1
            api_key: sk-your-api-key-here

        # 示例: 添加更多模型
        # - model_name: claude-3
        #   litellm_params:
        #     model: anthropic/claude-3-opus-20240229
        #     api_key: sk-your-anthropic-key

      general_settings:
        # Proxy 管理密钥 - 用于保护 proxy API
        master_key: sk-1234

        # 数据库配置 (可选，用于持久化 API keys 和配置)
        # database:
        #   url: sqlite:///#{var}/litellm/litellm.db

      litellm_settings:
        # 自动删除后端不支持的参数
        drop_params: True

        # 详细日志 (生产环境建议设为 False)
        set_verbose: False

        # 成功回调 (可选)
        # success_callback: ["prometheus"]

        # 失败回调 (可选)
        # failure_callback: ["slack"]
    YAML

    (etc/"litellm/config.yaml").write config_content unless (etc/"litellm/config.yaml").exist?
  end

  def caveats
    <<~EOS
      LiteLLM is a library to easily interface with LLM API providers.

      ─────────────────────────────────────────────────────────────
      配置文件已生成: #{etc}/litellm/config.yaml
      ─────────────────────────────────────────────────────────────

      使用方式:

      1. 编辑配置文件，设置你的后端 API 地址和密钥:
         edit #{etc}/litellm/config.yaml

      2. 启动 Proxy 服务:
         litellm --config #{etc}/litellm/config.yaml

         或指定端口:
         litellm --config #{etc}/litellm/config.yaml --port 4000

      3. 调用 Proxy API:
         curl http://localhost:4000/v1/chat/completions \\
           -H "Authorization: Bearer sk-1234" \\
           -H "Content-Type: application/json" \\
           -d '{"model": "gpt-4", "messages": [{"role": "user", "content": "Hello"}]}'

      ─────────────────────────────────────────────────────────────
      Python SDK 使用:
      ─────────────────────────────────────────────────────────────

        import litellm

        # 使用环境变量
        import os
        os.environ["OPENAI_API_BASE"] = "http://127.0.0.1:23333/v1"
        os.environ["OPENAI_API_KEY"] = "your-key"

        response = litellm.completion(
            model="gpt-4",
            messages=[{"role": "user", "content": "Hello!"}]
        )

      文档: https://docs.litellm.ai
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
