#!/usr/bin/env ruby

module BBC::Programmes

  class Version < Base
    type RDF::PO.Version

    default_vocabulary RDF::PO
    property :aspect_ratio, :type => String
    property :sound_format, :type => String
    property :duration, :type => Integer
    #property :time, :type => Timeline

    def self.id_for(identifier)
      if identifier.is_a?(::String)
        super(
          RDF::URI("#{base_uri}/#{identifier}#programme")
        )
      else
        super(identifier)
      end
    end

    def broadcasts
      # FIXME: can this be done using inverse properties?
      Broadcast.repository.query([nil, RDF::PO.broadcast_of, subject]).map do |b|
        Broadcast.for(b.subject)
      end
    end
  end

end
