module Foursquare2
  module Checkins

    # Retrive information about a single checkin.
    #
    # @param [String] checkin_id the ID of the checkin.
    # @param [Hash] options
    # @option options String :signature - Signature allowing users to bypass the friends-only access check on checkins

    def checkin(checkin_id, options={})
      response = connection.get do |req|
        req.url "checkins/#{checkin_id}", options
      end
      return_error_or_body(response, response.body.response.checkin)
    end

    # Retrive a list of recent checkins from friends.
    #
    # @param [Hash] options
    # @option options String :ll - Latitude and longitude in format LAT,LON
    # @option options String :limit - Maximum results to return (max 100)
    # @option options Integer :afterTimestamp - Seconds after which to look for checkins

    def recent_checkins(options={})
      response = connection.get do |req|
        req.url "checkins/recent", options
      end
      return_error_or_body(response, response.body.response.recent)
    end

    # Checkin on behalf of the user.
    #
    # @param [Hash] options
    # @option options String :venueId - Venue for the checkin.
    # @option options String :venue - For venueless checkins (name or other identifier)
    # @option options String :shout - Message to be included with the checkin.
    # @option options String :broadcast - Required, one or more of private,public,facebook,twitter.  Comma-separated.
    # @option options String :ll - Latitude and longitude in format LAT,LON
    # @option options Integer :llAcc - Accuracy of the lat/lon in meters.
    # @option options Integer :alt - Altitude in meters
    # @option options Integer :altAcc - Accuracy of the altitude in meters

    def add_checkin(options={})
      response = connection.post do |req|
        req.url "checkins/add", options
      end
      return_error_or_body(response, response.body.response.checkin)
    end

    # Add a comment to a checkin.
    #
    # @param [String] checkin_id the ID of the checkin.
    # @param [Hash]  options
    # @option options String :text - Text of the comment to add, 200 character max.

    def add_checkin_comment(checkin_id, options={})
      response = connection.post do |req|
        req.url "checkins/#{checkin_id}/addcomment", options
      end
      return_error_or_body(response, response.body.response)  
    end

    # Delete a checkin's comment
    #
    # @param [String] checkin_id - The ID of the checkin
    # @param [Hash]  options
    # @option options String :commentId - ID of the comment to be deleted.

    def delete_checkin_comment(checkin_id, options={})
      response = connection.post do |req|
        req.url "checkins/#{checkin_id}/deletecomment", options
      end
      return_error_or_body(response, response.body.response)  
    end

  end    
end

