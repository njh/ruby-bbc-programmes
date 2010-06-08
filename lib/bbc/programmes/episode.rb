#!/usr/bin/env ruby

module BBC::Programmes

  class Episode < Programme
    type RDF::PO.Episode
  
    has_many :versions, :type => 'BBC_Programmes_Version'
  end
  
end