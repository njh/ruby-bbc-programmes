#!/usr/bin/env ruby

module BBC::Programmes

  class TimeInterval
    include Spira::Resource

    type RDF::Timeline.Interval
    property :start, :predicate => RDF::Timeline.start, :type => Any
    property :end, :predicate => RDF::Timeline.end, :type => Any
    property :duration, :predicate => RDF::Timeline.end, :type => String # Duration
  end

end
