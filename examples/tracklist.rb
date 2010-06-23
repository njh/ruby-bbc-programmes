#!/usr/bin/env ruby
#
# Example of listing all the broadcasts for episode
#

$:.unshift(File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib')))

require 'rubygems'
require 'bbc/programmes'

Spira.add_repository(:default, RDF::Repository)

episode = BBC::Programmes::Episode.fetch('b00sk7q2')
puts "Episode: #{episode.title}"
puts

version = episode.versions.first.fetch!
version.segments.each do |segment|
  puts segment
end
