#!/usr/bin/env ruby

module BBC::Programmes

  class Programme < Base
    default_vocabulary RDF::PO
    property :title, :predicate => DC11.title, :type => String
    property :short_synopsis, :type => String
    property :medium_synopsis, :type => String
    property :long_synopsis, :type => String
    property :image, :predicate => FOAF.depiction, :type => RDF::URI

    # FIXME: this should be of type service
    property :masterbrand, :type => RDF::URI
    
    # FIXME: implement this
    #has_many :genres
    #has_many :formats
    
    def self.id_for(identifier)
      if identifier.is_a?(::String)
        super(
          RDF::URI("#{base_uri}/#{identifier}#programme")
        )
      else
        super(identifier)
      end
    end
  end

end
