#!/usr/bin/env ruby
# frozen_string_literal: true

# Auto-update IMA cask by scraping the download page JS bundle.
# Usage: ruby scripts/update_ima.rb Casks/ima.rb

require "net/http"
require "uri"
require "digest"

cask_file = ARGV[0]
abort "usage: update_ima.rb <cask_file>" unless cask_file

def fetch(url)
  uri = URI(url)
  Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == "https", read_timeout: 60) do |http|
    req = Net::HTTP::Get.new(uri)
    req["User-Agent"] = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7)"
    http.request(req)
  end
end

# Step 1: Parse download page → JS bundle filename
resp = fetch("https://ima.qq.com/download/?rmWeb=1")
js_match = resp.body.match(%r{assets/index-([a-zA-Z0-9_-]+)\.js})
abort "ERROR: Cannot find JS bundle in download page" unless js_match

js_url = "https://static.ima.qq.com/ima/assets/download/assets/index-#{js_match[1]}.js"

# Step 2: Extract Mac DMG URL from JS
resp = fetch(js_url)
dmg_match = resp.body.match(%r{https://ima-app\.image\.myqcloud\.com/app/[^"'\s]+\.dmg})
abort "ERROR: Cannot find Mac DMG URL in JS" unless dmg_match

dmg_url = dmg_match[0]
version_match = dmg_url.match(/_(\d+\.\d+\.\d+)_\d+\.dmg$/)
abort "ERROR: Cannot extract version from DMG URL: #{dmg_url}" unless version_match

version = version_match[1]

# Step 3: Compare with current version
content = File.read(cask_file)
cur_version = content.match(/^\s*version\s+"([^"]+)"/i)&.[](1)

puts "Current: #{cur_version || "(none)"}"
puts "Latest:  #{version}"

if cur_version == version
  puts "Already up to date."
  exit 0
end

# Step 4: Download DMG and compute sha256
puts "Downloading DMG to compute sha256..."
puts "URL: #{dmg_url}"
digest = Digest::SHA256.new
uri = URI(dmg_url)
Net::HTTP.start(uri.host, uri.port, use_ssl: true, read_timeout: 300) do |http|
  http.request(Net::HTTP::Get.new(uri)) do |resp|
    resp.read_body { |chunk| digest.update(chunk) }
  end
end
sha256 = digest.hexdigest
puts "SHA256: #{sha256}"

# Step 5: Rewrite cask file
content.sub!(/^\s*version\s+"[^"]+"/, "  version \"#{version}\"")
content.sub!(/^\s*sha256\s+"[^"]+"/, "  sha256 \"#{sha256}\"")
content.sub!(%r{https://ima-app\.image\.myqcloud\.com/app/[^"]+\.dmg}, dmg_url)
File.write(cask_file, content)
puts "Updated #{cask_file} to #{version}"
