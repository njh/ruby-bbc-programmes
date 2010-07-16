# Ruby client library for the BBC Programmes website

    require 'rubygems'
    require 'bbc/programmes'
    
    episode = BBC::Programmes::Episode.fetch('b00jnwnv')
    puts "PID: #{episode.pid}"
    puts "Title: #{episode.title}"
    puts "Short Synopsis: #{episode.short_synopsis}"
    puts "Medium Synopsis: #{episode.medium_synopsis}"
    puts "Long Synopsis: #{episode.long_synopsis}"
