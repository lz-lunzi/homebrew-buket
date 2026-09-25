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
      url "https://github.com/Kilo-Org/kilocode/releases/download/v7.8.1/kilo-darwin-arm64.zip"
      sha256 "d94ab724ce384f9a8e7cda72460c5eb643ed44cb481f80cdd4b7571d005cc0b1"
    end
    on_intel do
      url "https://github.com/Kilo-Org/kilocode/releases/download/v7.8.1/kilo-darwin-x64.zip"
      sha256 "99c6503f10a279acfa70c4476fe532267cce38ee85fca73217db4d7ad57ad8eb"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Kilo-Org/kilocode/releases/download/v7.8.1/kilo-linux-arm64.tar.gz"
      sha256 "516f81a81d3605cecae61dddf4da548da403b9f8993a06bb799d12b6fc6e7ac4"
    end
    on_intel do
      url "https://github.com/Kilo-Org/kilocode/releases/download/v7.8.1/kilo-linux-x64.tar.gz"
      sha256 "6d48503b000d3d904d15950b63e254653c450800647344ac0f3de4e8a7f98835"
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
