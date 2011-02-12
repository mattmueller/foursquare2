module Foursquare2
  module Photos

    # Retrive a photo
    #
    # @params [String] photo_id - The ID of the photo

    def photo(photo_id)
      response = connection.get("photos/#{photo_id}")
      return_error_or_body(response, response.body.response.photo)
    end    
    
  end
end

