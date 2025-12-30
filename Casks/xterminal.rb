cask "xterminal" do
  version "4.3.7"
  sha256 :no_check

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
