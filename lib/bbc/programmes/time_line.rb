#!/usr/bin/env ruby

module BBC::Programmes

  class TimeLine
    include Spira::Resource
    type RDF::TimeLine.TimeLine
  end

end
