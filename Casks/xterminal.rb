cask "xterminal" do
  version "4.3.7"
  sha256 "f764f567c2867b9fd2c6a797811a3c558db6f9e44db0dc9b6cc2ce12a9ab9be9"

  url "https://cdn-office.xterminal.cn/downloads/XTerminal-#{version}-mac-arm64.dmg",
      verified: "cdn-office.xterminal.cn"
  name "XTerminal"
  desc "Modern cross-platform terminal management tool with SSH, SFTP, and port forwarding"
  homepage "https://www.terminal.icu/"

  depends_on macos: ">= :monterey"

  app "XTerminal.app"

  caveats <<~EOS
    To get the actual SHA256 for verification:

    curl -L https://cdn-office.xterminal.cn/downloads/XTerminal-#{version}-mac-arm64.dmg -o XTerminal.dmg
    shasum -a 256 XTerminal.dmg

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
