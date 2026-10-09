#!/usr/bin/env ruby
# frozen_string_literal: true

# Update Formula/octop.rb from TencentCloud/Octop GitHub releases.
#
# Usage: update_octop.rb <formula_file> <github_owner/repo>
# Example: update_octop.rb Formula/octop.rb TencentCloud/Octop
#
# Portable assets are named "Octop-portable-<plat>-<version>.zip" where
# <plat> is darwin-arm64 / linux-amd64 / linux-arm64. The version suffix
# (e.g. "1.0.2b6") does not match update_multiarch.rb's ASSET_RE, so this
# script maps each darwin/linux asset to the url+sha256 pair whose url
# contains "Octop-portable-<plat>-" and rewrites it in place.

require "json"
require "net/http"
require "uri"

formula_file, repo = ARGV
abort "usage: update_octop.rb <formula_file> <owner/repo>" unless formula_file && repo

token = ENV["GITHUB_TOKEN"]
headers = token ? { "Authorization" => "Bearer #{token}" } : {}
uri = URI("https://api.github.com/repos/#{repo}/releases/latest")
response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) { |http| http.get(uri.request_uri, headers) }
abort "GitHub API error: #{response.code}" unless response.is_a?(Net::HTTPSuccess)

release = JSON.parse(response.body)
version = release["tag_name"].sub(/^v/, "")
assets = release["assets"]
puts "Latest version: #{version}"
puts "Assets: #{assets.map { |a| a['name'] }.join(', ')}"

content = File.read(formula_file)
changed = 0

# Update version field
if (m = content.match(/^(  version ")[^"]+(")/))
  content.sub!(m[0], "#{m[1]}#{version}#{m[2]}")
  changed += 1
end

ASSET_RE = /\AOctop-portable-(?<plat>darwin-arm64|linux-amd64|linux-arm64)-v?(?<ver>[\w.]+)\.zip\z/

assets.each do |asset|
  name = asset["name"]
  next unless (m = name.match(ASSET_RE))

  plat = m[:plat]
  url = asset["browser_download_url"]
  sha256 = asset["digest"].to_s.sub(/^sha256:/, "")
  if sha256.empty?
    puts "  WARN: #{name} has no sha256 digest, skipping"
    next
  end

  line_re = /^(\s*)url "([^"]*Octop-portable-#{Regexp.escape(plat)}-[^"]*)"\n(\s*)sha256 "[^"]+"/
  unless (line_m = content.match(line_re))
    puts "  WARN: no url+sha256 pair matches #{name} (plat=#{plat})"
    next
  end

  content.sub!(line_m[0], "#{line_m[1]}url \"#{url}\"\n#{line_m[3]}sha256 \"#{sha256}\"")
  puts "  #{name}: -> #{sha256[0, 12]}..."
  changed += 1
end

File.write(formula_file, content)
puts "Updated #{formula_file} to version #{version} (#{changed} substitutions)"
