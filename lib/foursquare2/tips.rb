module Foursquare2
  module Tips

    # Retrieve information about a tip.
    #
    # param [String] tip_id - The id of the tip to retrieve.

    def tip(tip_id)
      response = connection.get("tips/#{tip_id}")
      return_error_or_body(response, response.body.response.tip)
    end    

    # Search for tips.
    #
    # @param [Hash]  options
    # @option options String :ll - Latitude and longitude in format LAT,LON
    # @option options Integer :limit - The limit of results to return.
    # @option options Integer :offset - Used to page through results.
    # @option options String :filter - Set to 'friends' to limit tips to those from friends.
    # @option options String :query - Only find tips matching this term.

    def search_tips(options={})
      response = connection.get do |req|
        req.url "tips/search", options
      end
      return_error_or_body(response, response.body.response.tips)
    end

    # Search for tips from a venue.
    #
    # @param [String] venue_id - Venue id to flag, required.
    # @param [Hash]  options
    # @option options String :sort  [recent]  One of recent or popular.
    # @option options Integer :limit [100] Number of results to return, up to 500.
    # @option options Integer :offset [100] Used to page through results
    # @option options String :query - Only find tips matching this term.

    def venue_tips(venue_id, options={})
      query = options.delete(:query)
      response = connection.get do |req|
        req.url "venues/#{venue_id}/tips", options
      end
      tips = return_error_or_body(response, response.body.response.tips)
      tips = Foursquare2.filter(tips, query) if query
      tips
    end

    # Add a tip
    #
    # @param [Hash]  options
    # @option options String :venueId - Required, which venue to add the tip to.
    # @option options String :text - The text of the tip.
    # @option options String :url - Optionally associated url.

    def add_tip(options={})
      response = connection.post do |req|
        req.url "tips/add", options
      end
      return_error_or_body(response, response.body.response.tip)
    end

    # Mark a tip todo for the authenticated user.
    #
    # param [String] tip_id - The id of the tip to mark.

    def mark_tip_todo(tip_id)
      response = connection.post do |req|
        req.url "tips/#{tip_id}/marktodo"
      end
      return_error_or_body(response, response.body.response)
    end

    # Mark a tip done for the authenticated user.
    #
    # param [String] tip_id - The id of the tip to mark.

    def mark_tip_done(tip_id)
      response = connection.post do |req|
        req.url "tips/#{tip_id}/markdone"
      end
      return_error_or_body(response, response.body.response)
    end

    # Unmark a tip todo for the authenticated user.
    #
    # param [String] tip_id - The id of the tip to unmark.

    def unmark_tip(tip_id)
      response = connection.post do |req|
        req.url "tips/#{tip_id}/unmark"
      end
      return_error_or_body(response, response.body.response)
    end

  end
end
