#!/usr/bin/env ruby
#
# Example of searching for programmes by title
#

$:.unshift(File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib')))

require 'rubygems'
require 'bbc/programmes'

Spira.add_repository(:default, RDF::Repository)

programmes = BBC::Programmes.search('The Wire').each do |programme|
  puts "#{programme.pid}: #{programme.title}"
end
