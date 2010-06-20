$:.unshift(File.join(File.dirname(__FILE__),'..','lib'))

require 'rubygems'
require 'spec'
require 'mocha'

require 'bbc/programmes'


def fixture(filename)
  File.join(File.dirname(__FILE__),'data',filename)
end

def fixture_data(filename)
  File.read(fixture(filename))
end

Spec::Runner.configure do |config|
  config.mock_with :mocha
end

def mock_http(host, fixture_filename)
  response = stub(
    :value => nil,
    :body => fixture_data(fixture_filename),
    :content_type => 'application/rdf+xml'
  )
  Net::HTTP.expects(:start).with(host,nil).once.returns(response)
end

# FIXME: setup mock to never expect HTTP requests
