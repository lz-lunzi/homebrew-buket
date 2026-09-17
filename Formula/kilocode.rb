class Kilocode < Formula
  desc "终端 AI 编程助手 (Kilo Code CLI)"
  homepage "https://kilo.ai"
  license "MIT"

  # 官方 tap Kilo-Org/homebrew-tap 的 kilo.rb 由 GoReleaser 生成，
  # 用自包含二进制（无需 node）。本 formula 跟随其版本/GitHub release 资产，
  # 这样 livecheck + update_multiarch.rb 能自动 bump。
  #
  # 注意：不能用 registry.npmjs.org 的 @kilocode/cli tarball +
  # `system "npm", "install", *std_npm_args`。std_npm_args 含
  # --build-from-source / --ignore-scripts，会导致 npm 跳过
  # @kilocode/cli-<os>-<arch> 这类平台 optionalDependencies，
  # 运行时才报 "failed to install the right version for your platform"。
  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "ripgrep"

  on_macos do
    on_arm do
      url "https://github.com/Kilo-Org/kilocode/releases/download/v7.7.2/kilo-darwin-arm64.zip"
      sha256 "7cda880e22c12d50d20a6d298c3408520a995f199d0099d35e40f791bd5620ba"
    end
    on_intel do
      url "https://github.com/Kilo-Org/kilocode/releases/download/v7.7.2/kilo-darwin-x64.zip"
      sha256 "44d63186ae04fd5eb1761462531e0207abb1097e0acf135ee325cec17fdb9687"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Kilo-Org/kilocode/releases/download/v7.7.2/kilo-linux-arm64.tar.gz"
      sha256 "e0010d058a917d50d8e446c0692b941f732f21fac6b1a3127825bf17100e26b4"
    end
    on_intel do
      url "https://github.com/Kilo-Org/kilocode/releases/download/v7.7.2/kilo-linux-x64.tar.gz"
      sha256 "1bf998b10ee746f1061ed343c69e0c57bd7142bf2fe13f6b1db817596c8aa264"
    end
  end

  def install
    # darwin zip 内是平铺的：kilo / kilo-sandbox-mutation-worker.js / tree-sitter/
    # linux tarball 额外带 bwrap（沙箱）与 licenses/
    (libexec/"tree-sitter").mkpath
    %w[kilo kilo-sandbox-mutation-worker.js tree-sitter].each do |p|
      libexec.install p if File.exist?(p)
    end
    %w[bwrap licenses].each do |p|
      libexec.install p if File.exist?(p)
    end
    (bin/"kilo").write_env_script libexec/"kilo", KILO_TREE_SITTER_WASM_DIR: libexec/"tree-sitter"
  end

  def caveats
    <<~EOS
      Kilo Code CLI — 终端 AI 编程助手。

      快速开始:
        kilo --help

      登录 / 配置模型:
        kilo /login

      文档: https://kilo.ai/cli
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/kilo --version")
  end
end
