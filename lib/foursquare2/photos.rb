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
    
  end
end

