#!/usr/bin/env ruby

require 'rdf'
require 'rdf/raptor'
require 'rdf/po'
require 'net/http'
require 'addressable/uri'
require 'spira'


module BBC
  module Programmes
    BASE_URI = 'http://www.bbc.co.uk/programmes'
    USER_AGENT = "bbc-programmes-ruby/0.1"

    require 'bbc/programmes/base'
    require 'bbc/programmes/programme'
    require 'bbc/programmes/brand'
    require 'bbc/programmes/episode'
    require 'bbc/programmes/series'
    require 'bbc/programmes/version'
    #require 'bbc/programmes/broadcast'

    def self.search(keywords)
      encoded = Addressable::URI.encode(keywords)
      graph = http_get_graph("#{BASE_URI}/a-z/by/#{encoded}/all.rdf")

      # FIXME: push graph into the repository?

      programmes = []
      graph.query([nil, RDF.type, RDF::PO.Programme]) do |s|
        programme = Programme.for(s.subject)
        programme.title = graph.first_literal([s.subject, RDF::DC11.title, nil])
        programmes << programme
      end
      programmes
    end

    # Fetches and returns a Graph for an identifier
    def self.http_get_graph(uri)
      uri = RDF::URI(uri) unless uri.is_a?(RDF::URI)

      # FIXME: support other HTTP libraries too
      res = Net::HTTP.start(uri.host, uri.port) do |http|
        http.get(uri.request_uri, {
          'User-Agent' => USER_AGENT,
          'Accept' => 'application/rdf+xml'
        })
      end

      # Throw an exception if it failed
      res.value

      # Find a reader for the content type returned
      reader_class = RDF::Reader.for(:content_type => res.content_type)
      raise "No reader found for parsing: #{res.content_type}" if reader_class.nil?

      # Parse the RDF
      RDF::Graph.new(uri) do |graph|
        reader_class.new(res.body, :base_uri => uri) do |reader|
          reader.each_statement do |statement|
            graph << statement
          end
        end
      end
    end

    # Load a subject into the local repository
    def self.fetch(identifier)
      unless identifier.is_a?(RDF::URI)
        identifier = RDF::URI("#{BASE_URI}/#{identifier}")
      end

      graph = self.http_get_graph(identifier)

      type = graph.first_object([identifier, RDF.type, nil])
      raise "No type found for #{identifier}" if type.nil?

      klass = BBC::Programmes::Base.subclasses.find { |k| k.type == type }
      raise "No class found for #{identifier} of type #{type}" if klass.nil?

      # Add the graph to the repository of the type
      graph.each_statement do |s|
        klass.repository << s
      end

      klass.for(identifier)
    end

  end
end


# FIXME: hack for Spira not supporting namespaced resources
BBC_Programmes_Programme = BBC::Programmes::Programme
BBC_Programmes_Brand = BBC::Programmes::Brand
BBC_Programmes_Episode = BBC::Programmes::Episode
BBC_Programmes_Series = BBC::Programmes::Series
BBC_Programmes_Version = BBC::Programmes::Version
