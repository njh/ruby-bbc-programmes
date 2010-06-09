#!/usr/bin/env ruby

require 'rdf'
require 'rdf/raptor'
require 'rdf/po'
require 'spira'

module BBC
  module Programmes
    BASE_URI = 'http://www.bbc.co.uk/programmes'
    
    def self.search(keyword)
      encoded = Addressable::URI.encode(keyword)
      graph = RDF::Graph.load("#{BASE_URI}/a-z/by/#{encoded}/all.rdf")
      progs = graph.query([nil, RDF.type, RDF::PO.Programme]).map {|s| s.subject}
 
      # Add statements from the graph we loaded into the repository
      graph.each_statement do |s|
        BBC::Programmes::Programme.repository.insert(s)
      end
      
      progs.map {|p| p.as(BBC::Programmes::Programme)}
    end
    
    
    autoload :Brand,        'bbc/programmes/brand'
    autoload :Broadcast,    'bbc/programmes/broadcast'
    autoload :Episode,      'bbc/programmes/episode'
    autoload :Programme,    'bbc/programmes/programme'
    autoload :Series,       'bbc/programmes/series'
    autoload :Version,      'bbc/programmes/version'
  end
end


# FIXME: hack for Spira not supporting namespaced resources
BBC_Programmes_Programme = BBC::Programmes::Programme
BBC_Programmes_Brand = BBC::Programmes::Brand
BBC_Programmes_Episode = BBC::Programmes::Episode
BBC_Programmes_Series = BBC::Programmes::Series
BBC_Programmes_Version = BBC::Programmes::Version
