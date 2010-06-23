#!/usr/bin/env ruby

module BBC::Programmes

  class Segment < Base
    type RDF::PO.Segment

    default_vocabulary RDF::PO
    property :label, :predicate => RDF::RDFS.label, :type => String
    
    def to_s
      label
    end
    
    # FIXME: add support for fetching full details of a segment
  end

end
