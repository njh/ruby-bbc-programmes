#!/usr/bin/env ruby

module BBC::Programmes

  class Episode < Programme
    type RDF::PO.Episode
  
    default_vocabulary RDF::PO
    property :position, :type => Integer
    has_many :versions, :predicate => RDF::PO.version, :type => 'BBC_Programmes_Version'
  end
  
end