#!/usr/bin/env ruby

$:.unshift(File.join(File.dirname(__FILE__),'lib'))

require 'rubygems'
require 'bbc/programmes'

Spira.add_repository(:default, RDF::Repository)

BBC::Programmes.search('The Wire').each do |prog|
  puts "#{prog.pid}: #{prog.title}"
end
