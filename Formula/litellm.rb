class Litellm < Formula
  include Language::Python::Virtualenv

  desc "Library to easily interface with LLM API providers"
  homepage "https://github.com/BerriAI/litellm"
  url "https://files.pythonhosted.org/packages/9c/97/c9da198af273d700bf44d7d82eb21c5b8078c82574b31856b71b1298234b/litellm-1.98.0.tar.gz"
  sha256 "0e6ba5d645a73ca6d0ffb4e8ec539d94b6e8fad691f2a54c6819011e6d0de8bf"
  license "MIT"
  head "https://github.com/BerriAI/litellm.git", branch: "main"

  livecheck do
    url "https://pypi.org/pypi/litellm/json"
    regex(/"version"\s*:\s*"(\d+(?:\.\d+)+)"/i)
  end

  depends_on "rust" => :build

  depends_on "python@3.11"

  resource "aiohappyeyeballs" do
    url "https://files.pythonhosted.org/packages/ce/f4/eec0465c2f67b2664688d0240b3212d5196fd89e741df67ddb81f8d35658/aiohappyeyeballs-2.7.1.tar.gz"
    sha256 "065665c041c42a5938ed220bdcd7230f22527fbec085e1853d2402c8a3615d9d"
  end

  resource "aiohttp" do
    url "https://files.pythonhosted.org/packages/58/d9/22ce5786ac0c1653ae8b6c23bded02c1686d11f0dbb45b31ce128e0df985/aiohttp-3.14.3.tar.gz"
    sha256 "9491196535a88924a60afd5b5f434b5b203b6cc616250878dbdb223a8f7844bc"
  end

  resource "aiosignal" do
    url "https://files.pythonhosted.org/packages/61/62/06741b579156360248d1ec624842ad0edf697050bbaf7c3e46394e106ad1/aiosignal-1.4.0.tar.gz"
    sha256 "f47eecd9468083c2029cc99945502cb7708b082c232f9aca65da147157b251c7"
  end

  resource "annotated-types" do
    url "https://files.pythonhosted.org/packages/5f/56/a8120250d128bed162cd73c76d45f6ef9991f3e068f62a8ee060afa3104a/annotated_types-0.8.0.tar.gz"
    sha256 "13b2beaad985e05e2d6407ee4c4f35590b11f8d693a258a561055cac8f64cab7"
  end

  resource "anyio" do
    url "https://files.pythonhosted.org/packages/61/cc/a381afa6efea9f496eff839d4a6a1aed3bfafc7b3ab4b0d1b243a12573dd/anyio-4.14.2.tar.gz"
    sha256 "cfa139f3ed1a23ee8f88a145ddb5ac7605b8bbfd8592baacd7ce3d8bb4313c7f"
  end

  resource "attrs" do
    url "https://files.pythonhosted.org/packages/9a/8e/82a0fe20a541c03148528be8cac2408564a6c9a0cc7e9171802bc1d26985/attrs-26.1.0.tar.gz"
    sha256 "d03ceb89cb322a8fd706d4fb91940737b6642aa36998fe130a9bc96c985eff32"
  end

  resource "boto3" do
    url "https://files.pythonhosted.org/packages/ec/30/96cf7d324e75cd2c349e2911ae2334d987fb8525d551495a2ef6758c26f3/boto3-1.43.83.tar.gz"
    sha256 "6413d6e99f716af5d333a732db140e4b3359cac005a1271b11777b6d9ca82194"
  end

  resource "botocore" do
    url "https://files.pythonhosted.org/packages/ed/6f/cf16418004c832e6eb9abc6905fa323a3bf96a76ca7f2e97858801a4103e/botocore-1.43.83.tar.gz"
    sha256 "d9389b3b74400c34219965a2fb858c1d48744718865ee0496fd03bd5b21b943f"
  end

  resource "certifi" do
    url "https://files.pythonhosted.org/packages/a3/c2/24167ea9858356b47a87a50d39908bfdb72ceeefe0041586e704e5376b3a/certifi-2026.7.22.tar.gz"
    sha256 "741e2c3b351ddf169a738da9f2c048608ff7f2c5cc02f1ebc6b118bb090d5d55"
  end

  resource "charset-normalizer" do
    url "https://files.pythonhosted.org/packages/e5/3f/143b048436775b0f76ac3eec145c019e8173ccc2885c8f20319b996d5e83/charset_normalizer-3.5.1.tar.gz"
    sha256 "6117b84ea48435e5356dc737f5121485c30920ba43375fa7b434fd753df0eac3"
  end

  resource "click" do
    url "https://files.pythonhosted.org/packages/c7/0e/7fa0ef50764b67090eca4114772a2abf8b6148198475e54c660b97caeee6/click-8.5.0.tar.gz"
    sha256 "ba0d2089de75ea0310e2dde03160e6ca10009947fb95a182f9b54021bb272e34"
  end

  resource "distro" do
    url "https://files.pythonhosted.org/packages/fc/f8/98eea607f65de6527f8a2e8885fc8015d3e6f5775df186e443e0964a11c3/distro-1.9.0.tar.gz"
    sha256 "2fa77c6fd8940f116ee1d6b94a2f90b13b5ea8d019b98bc8bafdcabcdd9bdbed"
  end

  resource "fastuuid" do
    url "https://files.pythonhosted.org/packages/c3/7d/d9daedf0f2ebcacd20d599928f8913e9d2aea1d56d2d355a93bfa2b611d7/fastuuid-0.14.0.tar.gz"
    sha256 "178947fc2f995b38497a74172adee64fdeb8b7ec18f2a5934d037641ba265d26"
  end

  resource "filelock" do
    url "https://files.pythonhosted.org/packages/6d/30/03b03951873a1a0ffc7e8ca0e10c15597b59e8d0e39260704cd2ea087bc4/filelock-3.32.4.tar.gz"
    sha256 "2bde2e4cf732e0153406d8a7bc80620ecf5e621fe0d25e41143c4e3b4733ff30"
  end

  resource "frozenlist" do
    url "https://files.pythonhosted.org/packages/2d/f5/c831fac6cc817d26fd54c7eaccd04ef7e0288806943f7cc5bbf69f3ac1f0/frozenlist-1.8.0.tar.gz"
    sha256 "3ede829ed8d842f6cd48fc7081d7a41001a56f1f38603f9d49bf3020d59a31ad"
  end

  resource "fsspec" do
    url "https://files.pythonhosted.org/packages/00/78/f34251dadb8f3921264a1d9b8946f5e542014ee2614b285261b4e40e6775/fsspec-2026.7.0.tar.gz"
    sha256 "c803c40f4cf860b49dea58ee3e1c33cb9c790520e233537e1340049f89b82a88"
  end

  resource "h11" do
    url "https://files.pythonhosted.org/packages/01/ee/02a2c011bdab74c6fb3c75474d40b3052059d95df7e73351460c8588d963/h11-0.16.0.tar.gz"
    sha256 "4e35b956cf45792e4caa5885e69fba00bdbc6ffafbfa020300e549b208ee5ff1"
  end

  resource "hf-xet" do
    url "https://files.pythonhosted.org/packages/1b/ab/522a2ab67f27971a9d48ca666d4fca85ef7d5282d142e31fd087e27b1bbe/hf_xet-1.6.0.tar.gz"
    sha256 "2e58454a340b3556dfa4972d5451aff4fba8dd42a236600ba1a1d2b1514f0fef"
  end

  resource "httpcore" do
    url "https://files.pythonhosted.org/packages/06/94/82699a10bca87a5556c9c59b5963f2d039dbd239f25bc2a63907a05a14cb/httpcore-1.0.9.tar.gz"
    sha256 "6e34463af53fd2ab5d807f399a9b45ea31c3dfa2276f15a2c3f00afff6e176e8"
  end

  resource "httpx" do
    url "https://files.pythonhosted.org/packages/b1/df/48c586a5fe32a0f01324ee087459e112ebb7224f646c0b5023f5e79e9956/httpx-0.28.1.tar.gz"
    sha256 "75e98c5f16b0f35b567856f597f06ff2270a374470a5c2392242528e3e3e42fc"
  end

  resource "huggingface-hub" do
    url "https://files.pythonhosted.org/packages/64/35/42316e8f6908b6d21bc8df017cc6efba94fb5edbf99b64e28dd142325e20/huggingface_hub-1.29.0.tar.gz"
    sha256 "6ebb385a581435325cf6d5c5b233d5d4bc91175834d99fd65dae14379b36e9ad"
  end

  resource "idna" do
    url "https://files.pythonhosted.org/packages/5f/f7/abb373e5757eaec4b922b92f97ec8d6d7e057cf06778247604fbc4e7c3f3/idna-3.19.tar.gz"
    sha256 "5e0811a4383b21dc5838069f801c4fb62113b7447663d2530d2bd6e77b49bf15"
  end

  resource "importlib-metadata" do
    url "https://files.pythonhosted.org/packages/e7/72/c600ae4f68c28fc19f9c31b9403053e5dbb8cace2e6842c7b7c3e4d42fe9/importlib_metadata-8.9.0.tar.gz"
    sha256 "58850626cef4bd2df100378b0f2aea9724a7b92f10770d547725b047078f99ee"
  end

  resource "jinja2" do
    url "https://files.pythonhosted.org/packages/df/bf/f7da0350254c0ed7c72f3e33cef02e048281fec7ecec5f032d4aac52226b/jinja2-3.1.6.tar.gz"
    sha256 "0137fb05990d35f1275a587e9aee6d56da821fc83491a0fb838183be43f66d6d"
  end

  resource "jiter" do
    url "https://files.pythonhosted.org/packages/1d/1f/10936e16d8860c70698a1aa939a46aa0224813b782bce4e000e637da0b2d/jiter-0.16.0.tar.gz"
    sha256 "7b24c3492c5f4f84a37946ad9cf504910cf6a782d6a4e0689b6673c5894b4a1c"
  end

  resource "jmespath" do
    url "https://files.pythonhosted.org/packages/d3/59/322338183ecda247fb5d1763a6cbe46eff7222eaeebafd9fa65d4bf5cb11/jmespath-1.1.0.tar.gz"
    sha256 "472c87d80f36026ae83c6ddd0f1d05d4e510134ed462851fd5f754c8c3cbb88d"
  end

  resource "jsonschema" do
    url "https://files.pythonhosted.org/packages/b3/fc/e067678238fa451312d4c62bf6e6cf5ec56375422aee02f9cb5f909b3047/jsonschema-4.26.0.tar.gz"
    sha256 "0c26707e2efad8aa1bfc5b7ce170f3fccc2e4918ff85989ba9ffa9facb2be326"
  end

  resource "jsonschema-specifications" do
    url "https://files.pythonhosted.org/packages/19/74/a633ee74eb36c44aa6d1095e7cc5569bebf04342ee146178e2d36600708b/jsonschema_specifications-2025.9.1.tar.gz"
    sha256 "b540987f239e745613c7a9176f3edb72b832a4ac465cf02712288397832b5e8d"
  end

  resource "markupsafe" do
    url "https://files.pythonhosted.org/packages/7e/99/7690b6d4034fffd95959cbe0c02de8deb3098cc577c67bb6a24fe5d7caa7/markupsafe-3.0.3.tar.gz"
    sha256 "722695808f4b6457b320fdc131280796bdceb04ab50fe1795cd540799ebe1698"
  end

  resource "multidict" do
    url "https://files.pythonhosted.org/packages/1a/c2/c2d94cbe6ac1753f3fc980da97b3d930efe1da3af3c9f5125354436c073d/multidict-6.7.1.tar.gz"
    sha256 "ec6652a1bee61c53a3e5776b6049172c53b6aaba34f18c9ad04f82712bac623d"
  end

  resource "openai" do
    url "https://files.pythonhosted.org/packages/50/9a/8c75e8c8a5b407a0586faeb2afac91674ff955c191ecc1d6d3b6669f6788/openai-2.54.0.tar.gz"
    sha256 "e3e6f8bc1ba30ddf381ace1a14340eed381cb984a1a59bd0f34b5be3b5d49cfa"
  end

  resource "packaging" do
    url "https://files.pythonhosted.org/packages/7d/fa/3944b40b07da9ce895c0e6303a5ab7d53da063554f534556b134a54d6093/packaging-26.3.tar.gz"
    sha256 "94edc256424af38762eb31306eed28beb9f0efc50a8837492c9d6fd6004aed79"
  end

  resource "propcache" do
    url "https://files.pythonhosted.org/packages/ec/44/c87281c333769159c50594f22610f77398a47ccbfbbf23074e744e86f87c/propcache-0.5.2.tar.gz"
    sha256 "01c4fc7480cd0598bb4b57022df55b9ca296da7fc5a8760bd8451a7e63a7d427"
  end

  resource "pydantic" do
    url "https://files.pythonhosted.org/packages/53/ef/fc4f868f4e2cee79f863883abffceff107875f569b848507319842d2a681/pydantic-2.13.5.tar.gz"
    sha256 "51a9c5f7b2f8e636f04c6cada605d9b6a3bf1348fdf945a3d8869b19bba0ee08"
  end

  resource "pydantic-core" do
    url "https://files.pythonhosted.org/packages/af/f9/8a06bea35ef8daf588f707784c973a7046e0034c8d8cfb08828eeffb8b75/pydantic_core-2.46.5.tar.gz"
    sha256 "10416c15b8839ecc4ef4d0885da76da6fd0f67333a0eb8aff6d93c4b8f2910fc"
  end

  resource "pydantic-settings" do
    url "https://files.pythonhosted.org/packages/68/ca/31c57507b13119d7d3cfa1576dad2911a4861e3be07b579395f4e9d393f9/pydantic_settings-2.15.0.tar.gz"
    sha256 "694b793e84f766ba76a90ebdefc01d0a9a045dab0382bee70393da93712ad117"
  end

  resource "python-dateutil" do
    url "https://files.pythonhosted.org/packages/66/c0/0c8b6ad9f17a802ee498c46e004a0eb49bc148f2fd230864601a86dcf6db/python-dateutil-2.9.0.post0.tar.gz"
    sha256 "37dd54208da7e1cd875388217d5e00ebd4179249f90fb72437e91a35459a0ad3"
  end

  resource "python-dotenv" do
    url "https://files.pythonhosted.org/packages/6a/53/ed9d74092561d4b01a2ef1349d52cdbc135e526c245f366b089cfca6de49/python_dotenv-1.2.3.tar.gz"
    sha256 "a20a594dabeaa385725aa239d5244871c143ecb356add8a20fcf23773a6c3a35"
  end

  resource "pyyaml" do
    url "https://files.pythonhosted.org/packages/05/8e/961c0007c59b8dd7729d542c61a4d537767a59645b82a0b521206e1e25c2/pyyaml-6.0.3.tar.gz"
    sha256 "d76623373421df22fb4cf8817020cbb7ef15c725b9d5e45f17e189bfc384190f"
  end

  resource "referencing" do
    url "https://files.pythonhosted.org/packages/22/f5/df4e9027acead3ecc63e50fe1e36aca1523e1719559c499951bb4b53188f/referencing-0.37.0.tar.gz"
    sha256 "44aefc3142c5b842538163acb373e24cce6632bd54bdb01b21ad5863489f50d8"
  end

  resource "regex" do
    url "https://files.pythonhosted.org/packages/20/98/04b13f1ddfb63158025291c02e03eb42fbb7acb51d091d541050eb4e35e8/regex-2026.7.19.tar.gz"
    sha256 "7e77b324909c1617cbb4c668677e2c6ae13f44d7c1de0d4f15f2e3c10f3315b5"
  end

  resource "requests" do
    url "https://files.pythonhosted.org/packages/ac/c3/e2a2b89f2d3e2179abd6d00ebd70bff6273f37fb3e0cc209f48b39d00cbf/requests-2.34.2.tar.gz"
    sha256 "f288924cae4e29463698d6d60bc6a4da69c89185ad1e0bcc4104f584e960b9ed"
  end

  resource "rpds-py" do
    url "https://files.pythonhosted.org/packages/aa/2a/9618a122aeb2a169a28b03889a2995fe297588964333d4a7d67bdf46e147/rpds_py-2026.6.3.tar.gz"
    sha256 "1cebd1337c242e4ec2293e541f712b2da849b29f48f0c293684b71c0632625d4"
  end

  resource "s3transfer" do
    url "https://files.pythonhosted.org/packages/76/43/35e4d8aa320bffe8287fe8f65f578fa2d2db0a64212f0e710dce58267854/s3transfer-0.19.2.tar.gz"
    sha256 "ba0309fd86be3c27dbf78cdd813c13c5e1df16e5874b99d2535ebbdfb9892993"
  end

  resource "six" do
    url "https://files.pythonhosted.org/packages/94/e7/b2c673351809dca68a0e064b6af791aa332cf192da575fd474ed7d6f16a2/six-1.17.0.tar.gz"
    sha256 "ff70335d468e7eb6ec65b95b99d3a2836546063f63acc5171de367e834932a81"
  end

  resource "sniffio" do
    url "https://files.pythonhosted.org/packages/a2/87/a6771e1546d97e7e041b6ae58d80074f81b7d5121207425c964ddf5cfdbd/sniffio-1.3.1.tar.gz"
    sha256 "f4324edc670a0f49750a81b895f35c3adb843cca46f0530f79fc1babb23789dc"
  end

  resource "tiktoken" do
    url "https://files.pythonhosted.org/packages/66/62/167a842aa0429d45f5e797354fd4343a96f6043d67d0513c675c7b8d36e6/tiktoken-0.14.0.tar.gz"
    sha256 "231dec90efcdccf1b565a1416107736f1e09b1a08fe736ef9d6363e626d03874"
  end

  resource "tokenizers" do
    url "https://files.pythonhosted.org/packages/c1/60/21f715d9faba5f5407ff759472ade058ec4a507ad62bcea47cb847239a73/tokenizers-0.23.1.tar.gz"
    sha256 "1feeeadf865a7915adc25445dea30e9933e593c31bb96c277cee36de227c8bfa"
  end

  resource "tqdm" do
    url "https://files.pythonhosted.org/packages/21/3b/6c24bec5be5e743ffd99576daa5cc077722fc7d5bbc00bd133fa0c698dc6/tqdm-4.70.0.tar.gz"
    sha256 "55b0b0dbd97462d06ebee91e4dac24ed4d4702be82b24f07e6c1d27e08cea220"
  end

  resource "typing-extensions" do
    url "https://files.pythonhosted.org/packages/f6/cc/6253133b5bb138fc3306cebfbda2c520f545d36b5be2c7255cc528bb45d6/typing_extensions-4.16.0.tar.gz"
    sha256 "dc983d19a509c94dba722ee6abd33940f7c05a89e243c47e907eb4db6f1a43e5"
  end

  resource "typing-inspection" do
    url "https://files.pythonhosted.org/packages/a3/26/b09b8010994eccc3c09092e6b34058f36a460eea2d4c3e8b910c695975a0/typing_inspection-0.4.4.tar.gz"
    sha256 "547274fa6b0a561ccf549cc9524b999a578e737d015d8709d021f9d0d13bea47"
  end

  resource "urllib3" do
    url "https://files.pythonhosted.org/packages/53/0c/06f8b233b8fd13b9e5ee11424ef85419ba0d8ba0b3138bf360be2ff56953/urllib3-2.7.0.tar.gz"
    sha256 "231e0ec3b63ceb14667c67be60f2f2c40a518cb38b03af60abc813da26505f4c"
  end

  resource "yarl" do
    url "https://files.pythonhosted.org/packages/31/33/ebe9e3d1f86c7a0b51094c0a146392045ca1631d2664889539dec8088a33/yarl-1.24.5.tar.gz"
    sha256 "e81b83143bee16329c23db3c1b2d82b29892fcbcb849186d2f6e98a5abe9a57f"
  end

  resource "zipp" do
    url "https://files.pythonhosted.org/packages/b9/d8/eab98a517c14134c0b2eb4e2387bc5f457334293ec5d2dd3857ec2966802/zipp-4.1.0.tar.gz"
    sha256 "4cb57381f544315db7688e976e922a2b18cdb513d21cc194eb42232ba2a3e602"
  end

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
end
