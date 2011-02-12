module Foursquare2
  module Specials

    # Retrieve information about a special
    #
    # param [String] special_id The ID of the special

    def special(special_id)
      response = connection.get("specials/#{special_id}")
      return_error_or_body(response, response.body.response.special)
    end    

    # Search for specials
    #
    # @param [Hash]  options
    # @option options String :ll - Latitude and longitude in format LAT,LON
    # @option options Integer :llAcc - Accuracy of the lat/lon in meters.
    # @option options Integer :alt - Altitude in meters
    # @option options Integer :altAcc - Accuracy of the altitude in meters
    # @option options Integer :limit - The limit of results to return.

    def search_specials(options={})
      response = connection.get do |req|
        req.url "specials/search", options
      end
      return_error_or_body(response, response.body.response.specials.items)
    end
    
  end
end

