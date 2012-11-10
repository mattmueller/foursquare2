require 'faraday'
require 'faraday_middleware'

directory = File.expand_path(File.dirname(__FILE__))

module Foursquare2
  class << self

    FIELDS = [ :client_id, :client_secret, :api_version,
               :ssl, :connection_middleware, :locale ]
    attr_accessor(*FIELDS)

    def filter tips, term
      tip = []
      unless tips.nil?
        tips.items.each do |check_tip|
          tip << check_tip if check_tip.text.downcase.include? term.downcase
        end
      end
      Hashie::Mash.new({:count => tip.count, :items => tip })
    end

    def configure
      yield self
      true
    end

  end

  require 'foursquare2/campaigns'
  require 'foursquare2/users'
  require 'foursquare2/specials'
  require 'foursquare2/settings'
  require 'foursquare2/photos'
  require 'foursquare2/tips'
  require 'foursquare2/checkins'
  require 'foursquare2/venues'
  require 'foursquare2/pages'
  require 'foursquare2/lists'
  require 'foursquare2/events'
  require 'foursquare2/client'
  require 'foursquare2/api_error'


end

