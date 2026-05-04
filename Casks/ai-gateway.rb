cask "ai-gateway" do
  version "1.2.0"
  sha256 :no_check

  on_arm do
    url "https://github.com/keiskeies/ai-gateway/releases/download/v#{version}/AI.Gateway_#{version}_aarch64.dmg"
  end
  on_intel do
    url "https://github.com/keiskeies/ai-gateway/releases/download/v#{version}/AI.Gateway_#{version}_x64.dmg"
  end

  name "AI Gateway"
  desc "Cross-platform AI API aggregation gateway with smart load balancing"
  homepage "https://github.com/keiskeies/ai-gateway"

  livecheck do
    url "https://github.com/keiskeies/ai-gateway/releases"
    strategy :github_latest
  end

  depends_on macos: ">= :big_sur"

  app "AI Gateway.app"

  caveats <<~EOS
    AI Gateway is a cross-platform AI API aggregation gateway and smart traffic load balancer.

    Features:
    - Multi-key load balancing (5 strategies: round-robin, weighted random, least connections, priority, latency-first)
    - OpenAI & Anthropic dual-protocol support
    - Auto failover with exponential backoff retry
    - 15+ platform presets (OpenAI, Anthropic, DeepSeek, Qwen, GLM, etc.)
    - Remote model fetching and smart capability detection
  EOS
end
