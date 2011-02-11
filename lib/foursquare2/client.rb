require 'forwardable'

module Foursquare2
  class Client
    extend Forwardable
    
    include Venues
    include Checkins
    include Tips
    include Photos
    include Settings

    def initialize(oauth_token)
      @oauth_token = oauth_token
    end

    def connection
      params = {}
      params[:oauth_token] = @oauth_token
      @connection ||= Faraday::Connection.new(:url => api_url, :params => params, :headers => default_headers) do |builder|
        builder.adapter Faraday.default_adapter
        builder.use Faraday::Response::ParseJson
        builder.use Faraday::Response::Mashify
      end
    end

    def api_url
      "https://api.foursquare.com/v2"
    end

    def return_error_or_body(response, response_body)
      response.body.meta.code == 200 ? response_body : response.body
    end
      
    private

      def default_headers
        headers = {
          :accept =>  'application/json',
          :user_agent => 'Ruby gem'
        }
      end

  end
end
