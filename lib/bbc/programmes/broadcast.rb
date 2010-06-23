#!/usr/bin/env ruby

module BBC::Programmes

  class Broadcast < Base
    type RDF::PO.Broadcast

    default_vocabulary RDF::PO
    property :time, :predicate => RDF::URI('http://purl.org/NET/c4dm/event.owl#time'), :type => 'BBC_Programmes_TimeInterval'
    property :schedule_date, :type => String # Date
    property :broadcast_of, :type => 'BBC_Programmes_Version'
    property :broadcast_on, :type => 'BBC_Programmes_Service'

    def start
      time.nil? ? nil : time.start
    end

    def end
      time.nil? ? nil : time.end
    end

    def service
      broadcast_on
    end

    def version
      broadcast_of
    end

  end
end
