#!/usr/bin/env ruby

module BBC::Programmes

  class Service < Base
    type RDF::PO.Service

    default_vocabulary RDF::PO
    property :name, :predicate => RDF::RDFS.label, :type => String
    property :parent, :predicate => RDF::PO.parent_service, :type => 'BBC_Programmes_Service'
  end

end
