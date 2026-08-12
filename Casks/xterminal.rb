cask "xterminal" do
  version "4.3.7"
  sha256 "f764f567c2867b9fd2c6a797811a3c558db6f9e44db0dc9b6cc2ce12a9ab9be9"

  url "https://cdn-office.xterminal.cn/downloads/XTerminal-#{version}-mac-arm64.dmg",
      verified: "cdn-office.xterminal.cn"
  name "XTerminal"
  desc "Cross-platform terminal with SSH, SFTP, and port forwarding"
  homepage "https://www.terminal.icu/"

  livecheck do
    skip "SPA website; no public version API"
  end

  depends_on macos: :monterey

  app "XTerminal.app"

  caveats <<~EOS
    XTerminal features:
    - SSH Terminal: Multiple tabs, split screens, command history
    - SFTP File Transfer: Drag-and-drop, online editing
    - Port Forwarding: Local/Remote/SOCKS5 proxy
    - Local Terminal: Bash/Zsh/PowerShell support
    - AI Assistant: Command generation and error diagnosis
    - Server Monitoring: CPU/Memory/Disk/Network in real-time
    - Connection Management: Grouping, bookmarks, cloud sync
  EOS
end
