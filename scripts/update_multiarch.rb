#!/usr/bin/env ruby
# frozen_string_literal: true

# Update multi-architecture binary formulas from GitHub releases.
# Fetches all asset sha256s and updates URLs/sha256s for each architecture.
#
# Usage: update_multiarch.rb <formula_file> <github_owner/repo>
# Example: update_multiarch.rb Formula/omp.rb can1357/oh-my-pi

require "json"
require "net/http"
require "uri"

formula_file, repo = ARGV
abort "usage: update_multiarch.rb <formula_file> <owner/repo>" unless formula_file && repo

# Fetch latest release from GitHub API
api_url = "https://api.github.com/repos/#{repo}/releases/latest"
uri = URI(api_url)
response = Net::HTTP.get_response(uri)
abort "Failed to fetch #{api_url}: #{response.code}" unless response.is_a?(Net::HTTPSuccess)

release = JSON.parse(response.body)
version = release["tag_name"].sub(/^v/, "")
assets = release["assets"]

puts "Latest version: #{version}"
puts "Assets: #{assets.map { |a| a["name"] }.join(", ")}"

# Read formula
content = File.read(formula_file)

# Update version field if present
content.sub!(/version "[^"]+"/, "version \"#{version}\"")

# Update each architecture's URL and sha256
assets.each do |asset|
  name = asset["name"]
  url = asset["browser_download_url"]
  sha256 = asset["digest"].sub(/^sha256:/, "")

  # Match URL line and update it
  content.gsub!(/url "[^"]*#{Regexp.escape(name)}[^"]*"/, "url \"#{url}\"")

  # Find the sha256 line following this URL and update it
  content.gsub!(/(url "#{Regexp.escape(url)}"\s*\n\s*)sha256 "[^"]+"/, "\\1sha256 \"#{sha256}\"")
end

File.write(formula_file, content)
puts "Updated #{formula_file} to version #{version}"
