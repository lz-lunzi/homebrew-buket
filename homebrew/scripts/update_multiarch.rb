#!/usr/bin/env ruby
# frozen_string_literal: true

# Update multi-architecture binary formulas from GitHub releases.
#
# Usage: update_multiarch.rb <formula_file> <github_owner/repo>
# Example: update_multiarch.rb Formula/omp.rb can1357/oh-my-pi
#
# Formula URLs usually interpolate the version (v#{version}), so asset names
# cannot be matched literally. Asset names are parsed as
# "<pkg>-<version>-<arch>.<ext>" (version part optional), and the url line
# containing both <pkg> and <arch> has its url/sha256 pair rewritten.

require "json"
require "net/http"
require "uri"

ASSET_RE = /\A(?<pkg>.+?)-v?\d+(?:\.\d+)+-(?<arch>.+?)\.(?:tar\.(?:gz|xz|bz2)|tgz|zip|exe|AppImage|dmg|deb|rpm)\z/i
PLAIN_RE = /\A(?<pkg>.+?)-(?<arch>.+?)\z/

formula_file, repo = ARGV
abort "usage: update_multiarch.rb <formula_file> <owner/repo>" unless formula_file && repo

token = ENV["GITHUB_TOKEN"]
headers = token ? { "Authorization" => "Bearer #{token}" } : {}
uri = URI("https://api.github.com/repos/#{repo}/releases/latest")
response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) { |http| http.get(uri.request_uri, headers) }
abort "GitHub API error: #{response.code}" unless response.is_a?(Net::HTTPSuccess)

release = JSON.parse(response.body)
version = release["tag_name"].sub(/^v/, "")
assets = release["assets"]
puts "Latest version: #{version}"
puts "Assets: #{assets.map { |a| a["name"] }.join(", ")}"

content = File.read(formula_file)
changed = 0

# Update version field
if (m = content.match(/^(  version ")[^"]+(")/))
  content.sub!(m[0], "#{m[1]}#{version}#{m[2]}")
  changed += 1
end

assets.each do |asset|
  name = asset["name"]
  next if name.end_with?(".blockmap", ".sha256", ".txt")

  if (m = name.match(ASSET_RE))
    pkg, arch = m[:pkg], m[:arch]
  elsif (m = name.match(PLAIN_RE))
    pkg, arch = m[:pkg], m[:arch]
  else
    next
  end
  # Skip non-binary assets (SHA256SUMS, checksums, yml manifests, notices)
  next if pkg.match?(/sha256|checksum|latest|notice/i)

  url = asset["browser_download_url"]
  sha256 = asset["digest"].sub(/^sha256:/, "")

  line_re = /^(\s*)url "([^"]*#{Regexp.escape(pkg)}[^"]*#{Regexp.escape(arch)}[^"]*)"\n(\s*)sha256 "[^"]+"/
  unless (line_m = content.match(line_re))
    puts "  WARN: no url+sha256 pair matches #{name} (pkg=#{pkg} arch=#{arch})"
    next
  end

  content.sub!(line_m[0], "#{line_m[1]}url \"#{url}\"\n#{line_m[3]}sha256 \"#{sha256}\"")
  puts "  #{name}: -> #{sha256[0, 12]}..."
  changed += 1
end

File.write(formula_file, content)
puts "Updated #{formula_file} to version #{version} (#{changed} substitutions)"
