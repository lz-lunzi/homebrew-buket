#!/usr/bin/env ruby
# frozen_string_literal: true

# Insert deprecate!/disable! stanzas into a formula or cask .rb file.
# Follows Homebrew stanza order: deprecate!/disable! go after livecheck/no_autobump!
# (which come after homepage), and before auto_updates/conflicts_with/depends_on/container.
#
# Usage: add_retire.rb <file> <formula|cask> <name> <deprecate_date> <disable_date>

file, kind, name, dep_date, dis_date = ARGV
abort "usage: add_retire.rb <file> <formula|cask> <name> <deprecate_date> <disable_date>" unless file && kind && name && dep_date && dis_date

source = File.read(file)
if source.match?(/^\s*(deprecate!|disable!)\s/)
  warn "#{file}: already has deprecate!/disable!, skipping"
  exit 0
end

replacement_key = kind == "cask" ? "replacement_cask" : "replacement_formula"
reason = "moved to homebrew/#{kind == "cask" ? "cask" : "core"}"

stanza = "  deprecate! date: \"#{dep_date}\", because: \"#{reason}\", #{replacement_key}: \"#{name}\"\n" \
         "  disable! date: \"#{dis_date}\", because: \"#{reason}\", #{replacement_key}: \"#{name}\"\n"

lines = source.lines
# Find insertion index: after livecheck block (do...end), else after no_autobump!,
# else after homepage line. Track block depth to skip livecheck's nested ends.
insert_idx = nil
i = 0
while i < lines.size
  line = lines[i]
  if line =~ /^\s*livecheck\s+do\b/
    # Skip to matching end (depth counting)
    depth = 1
    i += 1
    while i < lines.size && depth > 0
      depth += lines[i].scan(/\bdo\b/).size
      depth += lines[i].scan(/\bdo\s*(\|[^|]*\|)?\s*$/).size
      depth -= lines[i].scan(/\bend\b/).size
      i += 1
    end
    insert_idx = i
    break
  elsif line =~ /^\s*no_autobump!\s/
    insert_idx = i + 1
    break
  elsif line =~ /^\s*homepage\s+["']/
    insert_idx = i + 1
    # Don't break; livecheck may still come later and should take precedence.
  end
  i += 1
end

unless insert_idx
  abort "#{file}: could not find insertion point (no homepage/livecheck/no_autobump!)"
end

# Ensure a blank line before the stanzas if the preceding line isn't blank.
pre = insert_idx > 0 ? lines[insert_idx - 1] : ""
stanza_block = stanza.lines
stanza_block.unshift("\n") unless pre.strip.empty?

# Ensure a blank line after unless the following line is blank.
nxt = lines[insert_idx] || ""
stanza_block << "\n" unless nxt.strip.empty?

lines.insert(insert_idx, *stanza_block)
File.write(file, lines.join)
puts "#{file}: added deprecate!/disable! at line #{insert_idx + 1} (replacement: #{name})"
