#!/usr/bin/env ruby
#
# Example of listing all the broadcasts for episode
#

$:.unshift(File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib')))

require 'rubygems'
require 'bbc/programmes'

Spira.add_repository(:default, RDF::Repository)

episode = BBC::Programmes::Episode.fetch('b00jnwnv')
puts "#{episode.pid}: #{episode.title}"

version = episode.versions.first.fetch!
version.broadcasts.each do |broadcast|
  puts "#{broadcast.start} - #{broadcast.end}  #{broadcast.service}"
end
