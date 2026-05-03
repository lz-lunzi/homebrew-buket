cask "xterminal" do
  version "4.3.7"
  sha256 "f764f567c2867b9fd2c6a797811a3c558db6f9e44db0dc9b6cc2ce12a9ab9be9"

  url "https://cdn-office.xterminal.cn/downloads/XTerminal-4.3.7-mac-arm64.dmg",
      verified: "cdn-office.xterminal.cn"
  name "XTerminal"
  desc "Modern cross-platform terminal management tool with SSH, SFTP, and port forwarding"
  homepage "https://www.terminal.icu/"

  depends_on macos: ">= :monterey"

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

  livecheck do
    url "https://www.terminal.icu/download"
    regex(/XTerminal[._-]v?(\d+(?:\.\d+)+)[._-]mac[._-]arm64\.dmg/i)
  end
end
