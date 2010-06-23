#!/usr/bin/env ruby

module BBC::Programmes

  class Version < Base
    type RDF::PO.Version

    default_vocabulary RDF::PO
    property :aspect_ratio, :type => String
    property :sound_format, :type => String
    property :duration, :type => Integer
    property :time, :predicate => RDF::PO.time, :type => 'BBC_Programmes_TimeInterval'

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
        b.subject.as(Broadcast)
      end
    end

    def timeline
      time.nil? ? nil : time.timeline
    end

    def intervals
      TimeInterval.repository.query([nil, RDF::TimeLine.timeline, timeline.subject]).map do |b|
        b.subject.as(TimeInterval)
      end
    end

    def segments
      intervals = self.intervals.select {|i| !i.position.nil?}
      intervals.sort! {|a,b| (a.position.to_i||0) <=> (b.position.to_i||0)}
      intervals.map do |interval|
        segment = Segment.repository.first_subject([nil, RDF::PO.time, interval.subject])
        segment.nil? ? nil : segment.as(Segment)
      end
    end
  end

end
