require 'forwardable'

module Foursquare2
  class Client
    extend Forwardable
    
    include Venues
    include Checkins
    include Tips
    include Photos
    include Settings
    include Specials
    include Users

    attr_reader :client_id, :client_secret, :oauth_token

    #Initialize the client class that will be used for all foursquare API requests.  Note that either a valid user oauth token OR a valid client_id + secret is required.
    #
    #Certain requests will require an oauth token.  See http://developer.foursquare.com/docs/index_docs.html for the full list.
    #
    # @param [Hash] options
    # @option options String :client_id Your foursquare app's client_id
    # @option options String :client_secret Your foursquare app's client_secret
    # @option options String :oauth_token A valid oauth token for a user (or the 'secret' value from api v1)
    # @option options Hash   :ssl Additional SSL options (like the path to certificate file)
    
    def initialize(options={})
      @client_id = options[:client_id]
      @client_secret = options[:client_secret]
      @oauth_token = options[:oauth_token]
      @ssl = options[:ssl].nil? ? Hash.new : options[:ssl]
    end
    
    def ssl
      @ssl
    end
    
    # Sets up the connection to be used for all requests based on options passed during initialization.

    def connection
      params = {}
      params[:client_id] = @client_id if @client_id
      params[:client_secret] = @client_secret if @client_secret
      params[:oauth_token] = @oauth_token if @oauth_token
      @connection ||= Faraday::Connection.new(:url => api_url, :ssl => @ssl, :params => params, :headers => default_headers) do |builder|
        builder.adapter Faraday.default_adapter
        builder.use Faraday::Response::Mashify
        builder.use Faraday::Response::ParseJson
      end
    end

    # Base URL for api requests.

    def api_url
      "https://api.foursquare.com/v2"
    end

    # Helper method to return errors or desired response data as appropriate.
    #
    # Added just for convenience to avoid having to traverse farther down the response just to get to returned data.

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
