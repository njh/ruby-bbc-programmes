#!/usr/bin/env ruby

module RDF

  ##
  # Programmes Ontology vocabulary.
  #
  # @see http://purl.org/ontology/po/
  class PO < RDF::Vocabulary('http://purl.org/ontology/po/')
    property :Brand
    property :Series
    property :Episode
    property :Programme
    property :Version
  end

end
