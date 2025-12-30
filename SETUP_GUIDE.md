# Homebrew Tap 设置指南

## 1. 初始化 Git 仓库

```bash
cd /Users/liu/Code/homebrew-buket
git init
git add .
git commit -m "Initial commit: Add qodercli formula and cask"
```

## 2. 在 GitHub 创建仓库

1. 访问 https://github.com/new
2. 创建名为 `homebrew-buket` 的公开仓库
3. 不要初始化 README（本地已有）

## 3. 关联远程仓库并推送

```bash
git remote add origin https://github.com/你的用户名/homebrew-buket.git
git branch -M main
git push -u origin main
```

## 4. 使用你的 Tap

```bash
# 添加 tap
brew tap 你的用户名/homebrew-buket

# 安装 qodercli
brew install qodercli

# 验证安装
qodercli --version
```

## 5. 更新 Formula

当你需要更新版本时：

1. 修改 `Formula/qodercli.rb` 或 `Casks/qodercli.rb` 中的版本号和 sha256
2. 获取正确的 sha256：

```bash
# 下载文件并计算 sha256
curl -L https://your-download-url -o /tmp/file.tgz
shasum -a 256 /tmp/file.tgz
```

3. 提交并推送：

```bash
git add .
git commit -m "Update qodercli to version X.X.X"
git push
```

## 6. 更新本地 tap

用户更新你的 tap：

```bash
brew update
brew upgrade qodercli
```

## Formula 结构说明

### Formula（命令行工具）
```ruby
class Toolname < Formula
  desc "工具描述"
  homepage "工具主页"
  url "下载链接"
  sha256 "校验码"
  license "许可证"

  depends_on "依赖项"

  def install
    # 安装逻辑
  end

  test do
    # 测试逻辑
  end
end
```

### Cask（图形界面应用）
```ruby
cask "appname" do
  version "版本号"
  sha256 "校验码"

  url "下载链接"
  name "应用名称"
  desc "应用描述"
  homepage "主页"

  app "应用.app"

  zap trash: "~/.app-config"
end
```

## 常见问题

### Q: 如何找到工具的下载链接？
A: 通常在工具的 GitHub Releases 页面或官方网站下载页面

### Q: sha256 如何获取？
A:
```bash
curl -L URL -o file.ext
shasum -a 256 file.ext
```

### Q: 如何查看已安装的 tap？
A:
```bash
brew tap-info your-username/homebrew-buket
```

### Q: 如何移除 tap？
A:
```bash
brew untap your-username/homebrew-buket
```
