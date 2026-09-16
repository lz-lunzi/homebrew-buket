#!/usr/bin/env ruby
# frozen_string_literal: true

# Update Formula/cline.rb from the npm registry.
#
# cline ships platform binaries as npm packages (@cline/cli-<os>-<arch>);
# GitHub releases carry no binary assets, so update_multiarch.rb can't apply.
# Usage: update_cline.rb Formula/cline.rb

require "json"
require "net/http"
require "uri"

formula_file = ARGV[0]
abort "usage: update_cline.rb <formula_file>" unless formula_file

uri = URI("https://registry.npmjs.org/cline")
response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) { |http| http.get(uri.request_uri) }
abort "npm registry error: #{response.code}" unless response.is_a?(Net::HTTPSuccess)
version = JSON.parse(response.body)["dist-tags"]["latest"]
abort "no latest tag" unless version

content = File.read(formula_file)
old = content.scan(/version "([^"]+)"/).flatten.first
if old == version
  puts "cline already at #{version}"
  exit 0
end

# Rewrite the version line and every platform tarball URL + sha256 pair.
content.sub!(/^(  version ")[^"]+(")/) { "#{Regexp.last_match(1)}#{version}#{Regexp.last_match(2)}" }

["darwin-arm64", "darwin-x64", "linux-arm64", "linux-x64"].each do |plat|
  url = "https://registry.npmjs.org/@cline/cli-#{plat}/-/cli-#{plat}-#{version}.tgz"
  tarball = Net::HTTP.get_response(URI(url))
  abort "fetch failed for #{plat}: #{tarball.code}" unless tarball.is_a?(Net::HTTPSuccess)

  require "digest/sha2"
  sha = Digest::SHA256.hexdigest(tarball.body)
  line_re = /(@cline\/cli-#{plat}\/-\/cli-#{plat}-)(?:[^"]+|\#\{version\})\.tgz(",\n\s*using: :nounzip\n\s*sha256 ")[^"]+(")/
  content.sub!(line_re) { "#{Regexp.last_match(1)}\#{version}.tgz#{Regexp.last_match(2)}#{sha}#{Regexp.last_match(3)}" } or abort "no match for #{plat}"
  puts "  #{plat}: -> #{sha[0, 12]}..."
end

File.write(formula_file, content)
puts "Updated #{formula_file} to #{version}"
