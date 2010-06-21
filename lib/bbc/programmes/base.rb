#!/usr/bin/env ruby

module BBC::Programmes

  class Base
    include Spira::Resource

    base_uri BBC::Programmes::BASE_URI
    default_vocabulary RDF::PO

    property :pid, :type => String

    def self.fetch(identifier)
      programme = self.for(identifier)
      programme.fetch!
      programme
    end

    def fetch!
      BBC::Programmes.fetch(subject)
      self.reload
      self
    end

    def pid
      pid = attribute_get(:pid)
      if pid.nil?
        subject.to_s =~ /(\w+)\#(\w+)$/
        pid = $1
      end
      pid
    end

    def self.subclasses
      subclasses = []
      ObjectSpace.each_object(Class) do |klass|
        if klass.ancestors.include?(self)
          subclasses << klass
        end
      end
      subclasses
    end

  end

end
