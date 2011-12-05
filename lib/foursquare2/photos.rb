module Foursquare2
  module Photos

    # Retrieve a photo
    #
    # @params [String] photo_id - The ID of the photo

    def photo(photo_id)
      response = connection.get("photos/#{photo_id}")
      return_error_or_body(response, response.body.response.photo)
    end    

    # Add a photo
    #
    # @param [Hash] options
    # @option options UploadIO :photo - the photo. Like Faraday::UploadIO.new('pic_path', 'image/jpeg')
    # @option options String :checkinId - the ID of a checkin owned by the user
    # @option options String :tipId - the ID of a tip owned by the user
    # @option options String :venueId - the ID of a venue
    # @option options String :broadcast - Required, one or more of private,public,facebook,twitter. Comma-separated.
    # @option options String :ll - Latitude and longitude in format LAT,LON
    # @option options Integer :llAcc - Accuracy of the lat/lon in meters.
    # @option options Integer :alt - Altitude in meters
    # @option options Integer :altAcc - Accuracy of the altitude in meters
    def add_photo(options={})
      response = connection.post('photos/add', options)
      return_error_or_body(response, response.body.response.photo)
    end
    
    # Retrieve photos for a venue
    #
    # @params [String] venue_id - The ID of the venue
    # @param [Hash] options
    # @option options String :group - Pass checkin for photos added by friends (including on their recent checkins). Pass venue for public photos added to the venue by non-friends. Use multi to fetch both. Default - venue
    # @option options Integer :limit - Number of results to return, up to 500.
    # @option options Integer :offset - Used to page through results.
    def venue_photos(venue_id, options = {:group => 'venue'})
      response = connection.get do |req|
        req.url "venues/#{venue_id}/photos", options
      end
      return_error_or_body(response, response.body.response.photos)
    end
    
  end
end

