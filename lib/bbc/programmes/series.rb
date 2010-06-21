#!/usr/bin/env ruby

module BBC::Programmes

  class Series < Programme
    type RDF::PO.Series
      
    default_vocabulary RDF::PO
    property :position, :type => Integer
    has_many :series, :predicate => RDF::PO.series, :type => 'BBC_Programmes_Series'
    has_many :episodes, :predicate => RDF::PO.episode, :type => 'BBC_Programmes_Episode'
  end
    
end
