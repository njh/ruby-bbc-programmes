#!/usr/bin/env ruby

module BBC::Programmes

  class Programme
    include Spira::Resource
  
    base_uri BBC::Programmes::BASE_URI
    default_vocabulary RDF::PO
    
    property :title, :predicate => DC11.title, :type => String
    property :short_synopsis, :type => String
    property :medium_synopsis, :type => String
    property :long_synopsis, :type => String
    property :image, :predicate => FOAF.depiction, :type => RDF::URI
    
    def self.load(identifier)
      programme = self.new(identifier)
      programme.load!
    end
    
    def self.id_for(identifier)
      if identifier.is_a?(::String)
        super(
          RDF::URI.parse("#{base_uri}/#{identifier}##{fragment_id}")
        )
      else
        super(identifier)
      end
    end
    
    def self.fragment_id
      "programme"
    end
    
    def load!
      self.class.repository.load(subject, :format => :rdfxml)
      self.reload
      self
    end
    
  end

end
