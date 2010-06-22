#!/usr/bin/env ruby
#
# Basic example of getting the title and synopsis for an episode
#

$:.unshift(File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib')))

require 'rubygems'
require 'bbc/programmes'

Spira.add_repository(:default, RDF::Repository)


episode = BBC::Programmes::Episode.fetch('b00jnwnv')
puts "PID: #{episode.pid}"
puts "Title: #{episode.title}"
puts "Short Synopsis: #{episode.short_synopsis}"
puts "Medium Synopsis: #{episode.medium_synopsis}"
puts "Long Synopsis: #{episode.long_synopsis}"
