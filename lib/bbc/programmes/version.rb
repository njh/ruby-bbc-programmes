#!/usr/bin/env ruby

module BBC::Programmes

  class Version
    include Spira::Resource
  
    base_uri BBC::Programmes::BASE_URI
    default_vocabulary RDF::PO
    type RDF::PO.Version
  end

end
