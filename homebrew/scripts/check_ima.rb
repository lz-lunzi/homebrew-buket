#!/usr/bin/env ruby
# frozen_string_literal: true

# Check IMA (ima.qq.com) latest version by parsing download page JS
# Usage: ruby scripts/check_ima.rb

require "net/http"
require "uri"
require "json"

def fetch(url)
  uri = URI(url)
  Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == "https") do |http|
    req = Net::HTTP::Get.new(uri)
    req["User-Agent"] = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7)"
    http.request(req)
  end
end

# Step 1: Get download page HTML
puts "Fetching download page..."
resp = fetch("https://ima.qq.com/download/?rmWeb=1")
html = resp.body

# Step 2: Extract JS bundle filename
js_match = html.match(%r{assets/index-([a-zA-Z0-9_-]+)\.js})
unless js_match
  puts "ERROR: Cannot find JS bundle in download page"
  exit 1
end
js_hash = js_match[1]
js_url = "https://static.ima.qq.com/ima/assets/download/assets/index-#{js_hash}.js"
puts "JS bundle: #{js_url}"

# Step 3: Fetch JS and extract Mac DMG URL
puts "Fetching JS bundle..."
resp = fetch(js_url)
js_content = resp.body

dmg_match = js_content.match(%r{https://ima-app\.image\.myqcloud\.com/app/[^"'\s]+\.dmg})
unless dmg_match
  puts "ERROR: Cannot find Mac DMG URL in JS"
  exit 1
end
dmg_url = dmg_match[0]
puts "DMG URL: #{dmg_url}"

# Step 4: Extract version from URL
# Pattern: ima.copilot_universal_1018_2.3.0_3717.dmg
version_match = dmg_url.match(/_(\d+\.\d+\.\d+)_\d+\.dmg$/)
unless version_match
  puts "ERROR: Cannot extract version from DMG URL"
  exit 1
end
version = version_match[1]
puts "Version: #{version}"

# Step 5: Output JSON for auto-update workflow
result = {
  version: version,
  url: dmg_url,
  js_hash: js_hash
}
puts "\n=== RESULT ==="
puts JSON.pretty_generate(result)
