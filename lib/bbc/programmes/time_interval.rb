#!/usr/bin/env ruby

module BBC::Programmes

  class TimeInterval
    include Spira::Resource

    type RDF::TimeLine.Interval
    property :start, :predicate => RDF::TimeLine.start, :type => Any
    property :end, :predicate => RDF::TimeLine.end, :type => Any
    property :duration, :predicate => RDF::TimeLine.end, :type => String # Duration
    property :position, :predicate => RDF::PO.position, :type => Integer
    property :timeline, :predicate => RDF::TimeLine.timeline, :type => 'BBC_Programmes_TimeLine'
  end

end
