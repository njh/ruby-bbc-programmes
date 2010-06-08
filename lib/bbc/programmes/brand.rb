#!/usr/bin/env ruby

module BBC::Programmes

  class Brand < Programme
    type RDF::PO.Brand
  
    has_many :series, :predicate => RDF::PO.series, :type => 'BBC_Programmes_Series'
    has_many :episodes, :predicate => RDF::PO.episode, :type => 'BBC_Programmes_Episode'
  end

end
