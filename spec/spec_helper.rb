$:.unshift(File.join(File.dirname(__FILE__),'..','lib'))

require 'rubygems'
require 'bbc/programmes'
require 'spec'
require 'mocha'

def fixture(filename)
  File.join(File.dirname(__FILE__),'data',filename)
end

def fixture_data(filename)
  File.read(fixture(filename))
end

Spec::Runner.configure do |config|
  config.mock_with :mocha
end

# FIXME: setup mock to never expect HTTP requests
