require 'forwardable'

module Foursquare2
  class Client
    DEFAULT_CONNECTION_MIDDLEWARE = [
      Faraday::Request::Multipart,
      Faraday::Request::UrlEncoded,
      FaradayMiddleware::Mashify,
      FaradayMiddleware::ParseJson
    ]

    extend Forwardable

    include Venues
    include Checkins
    include Tips
    include Photos
    include Settings
    include Specials
    include Users
    include Pages
    include Campaigns
    include Lists
    include Events

    attr_reader :client_id, :client_secret, :oauth_token, :api_version, :locale

    #Initialize the client class that will be used for all foursquare API requests.  Note that either a valid user oauth token OR a valid client_id + secret is required.
    #
    #Certain requests will require an oauth token.  See http://developer.foursquare.com/docs/index_docs.html for the full list.
    #
    # @param [Hash] options
    # @option options String :client_id Your foursquare app's client_id
    # @option options String :client_secret Your foursquare app's client_secret
    # @option options String :oauth_token A valid oauth token for a user (or the 'secret' value from api v1)
    # @option options String :api_version A date formatted as YYYYMMDD indicating the API version you intend to use
    # @option options Array  :connection_middleware A collection of different middleware to be applied when the connection is created
    # @option options Hash   :ssl Additional SSL options (like the path to certificate file)

    def initialize(options={})
      @client_id = options[:client_id] || Foursquare2.client_id
      @client_secret = options[:client_secret] || Foursquare2.client_secret
      @oauth_token = options[:oauth_token]
      @api_version = options[:api_version] || Foursquare2.api_version
      @locale = options[:locale] || Foursquare2.locale
      @ssl = options[:ssl] || Foursquare2.ssl || Hash.new
      @connection_middleware = options[:connection_middleware] || Foursquare2.connection_middleware || []
      @connection_middleware += DEFAULT_CONNECTION_MIDDLEWARE
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
      params[:v] = @api_version if @api_version
      params[:locale] = @locale if @locale
      @connection ||= Faraday::Connection.new(:url => api_url, :ssl => @ssl, :params => params, :headers => default_headers) do |builder|
        @connection_middleware.each do |middleware|
          builder.use *middleware
        end
        builder.adapter Faraday.default_adapter
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
      if response.body.meta.code == 200
        response_body
      else
        raise Foursquare2::APIError.new(response.body.meta, response.body.response)
      end
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
