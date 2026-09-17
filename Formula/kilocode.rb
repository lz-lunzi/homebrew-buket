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
      url "https://github.com/Kilo-Org/kilocode/releases/download/v7.7.3/kilo-darwin-arm64.zip"
      sha256 "c1e6678b9a7f7c60f03f752483c7c0c83316b5fd47b9670bbd656285b576d13e"
    end
    on_intel do
      url "https://github.com/Kilo-Org/kilocode/releases/download/v7.7.3/kilo-darwin-x64.zip"
      sha256 "6f7c6692891ff9df8b4aee3dd840358b5b62e7f3d4f592375d1a196b634d4b02"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Kilo-Org/kilocode/releases/download/v7.7.3/kilo-linux-arm64.tar.gz"
      sha256 "5e0401974e2dd5c6a59b736dd7def026b1db0845d230862f428fdfeec4e261d5"
    end
    on_intel do
      url "https://github.com/Kilo-Org/kilocode/releases/download/v7.7.3/kilo-linux-x64.tar.gz"
      sha256 "9989ba0c0ca6c02aeda7592f9daab6aed4494648186a72dc53f409dfb623f4d6"
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
