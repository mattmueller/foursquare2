require 'faraday'
require 'faraday_middleware'

directory = File.expand_path(File.dirname(__FILE__))

module Foursquare2
  class << self

    def filter tips, term
      tip = []
      unless tips.nil?
        tips.items.each do |check_tip| 
          tip << check_tip if check_tip.text.include? term
        end
      end
      {:count => tip.count,:items => tip}
    end

  end

  require 'foursquare2/users'
  require 'foursquare2/specials'
  require 'foursquare2/settings'
  require 'foursquare2/photos'
  require 'foursquare2/tips'
  require 'foursquare2/checkins'
  require 'foursquare2/venues'
  require 'foursquare2/client'
  require 'foursquare2/hash'

end

