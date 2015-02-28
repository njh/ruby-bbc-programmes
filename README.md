# Ruby client library for the BBC Programmes website

    require 'rubygems'
    require 'bbc/programmes'
    
    episode = BBC::Programmes::Episode.fetch('b00jnwnv')
    puts "PID: #{episode.pid}"
    puts "Title: #{episode.title}"
    puts "Short Synopsis: #{episode.short_synopsis}"
    puts "Medium Synopsis: #{episode.medium_synopsis}"
    puts "Long Synopsis: #{episode.long_synopsis}"


License
-------

The bbc-programmes gem is licensed under the terms of the MIT license.
See the file LICENSE for details.


Contact
-------

* Author:    Nicholas J Humfrey
* Email:     njh@aelius.com
* Home Page: http://www.aelius.com/njh/
