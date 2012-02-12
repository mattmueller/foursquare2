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
    
    # Add a special for venue managers
    # Details on param options can be found at https://developer.foursquare.com/docs/specials/add
    #
    # @param [Hash]  options
    # @option options String :name - A name for the special.
    # @option options String :text - Required
    # @option options String :unlockedText - Required. Special text that is shown when the user has unlocked the special.
    # @option options String :finePrint 
    # @option options Integer :count1 
    # @option options Integer :count2 
    # @option options Integer :count3 
    # @option options String :type - Required.
    # @option options String :offerId
    # @option options Float :cost
    #

    def add_special(options={})
      response = connection.post do |req|
        req.url "specials/add", options
      end
        return_error_or_body(response, response.body.response.special)
    end
    
  end
end

