module Foursquare2
  module Venues

    def venue(venue_id)
      response = connection.get("venues/#{venue_id}")
      return_error_or_body(response, response.body.response.venue)
    end

  end 
end
