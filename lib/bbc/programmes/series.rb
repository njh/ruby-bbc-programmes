#!/usr/bin/env ruby

module BBC::Programmes

  class Series < Programme
    type RDF::PO.Series
      
    has_many :series, :predicate => RDF::PO.series, :type => 'BBC_Programmes_Series'
    has_many :episodes, :predicate => RDF::PO.episode, :type => 'BBC_Programmes_Episode'
  end
    
end
