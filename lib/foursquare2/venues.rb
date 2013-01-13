module Foursquare2
  module Venues

    # Retrieve information about a venue
    #
    # param [String] venue_id The ID of the venue

    def venue(venue_id)
      response = connection.get("venues/#{venue_id}")
      return_error_or_body(response, response.body.response.venue)
    end

    # Search for venues
    #
    # @param [Hash]  options
    # @option options String :ll - Latitude and longitude in format LAT,LON
    # @option options Integer :llAcc - Accuracy of the lat/lon in meters.
    # @option options Integer :alt - Altitude in meters
    # @option options Integer :altAcc - Accuracy of the altitude in meters
    # @option options Integer :limit - The limit of results to return.
    # @option options String :intent - One of checkin, match, or specials.
    # @option options String :query - Query to match venues on.

    def search_venues(options={})
      response = connection.get do |req|
        req.url "venues/search", options
      end
      return_error_or_body(response, response.body.response)
    end
    
    # Search for trending venues
    #
    # @param [String] :ll Latitude and longitude in format LAT,LON
    # @param [Hash]  options
    # @option options Integer :limit - Number of results to return, up to 50.
    # @option options Integer :radius - Radius in meters, up to approximately 2000 meters.

    def trending_venues(ll, options={})
      options[:ll] = ll    
      response = connection.get do |req|
        req.url "venues/trending", options
      end
      return_error_or_body(response, response.body.response)
    end

    # Search for venues by tip
    #
    # @param [Hash]  options
    # @option options String :ll - Latitude and longitude in format LAT,LON
    # @option options Integer :limit - The limit of results to return.
    # @option options Integer :offset - Used to page through results.
    # @option options String :filter - Set to 'friends' to limit tips to those from friends.
    # @option options String :query - Only find tips matching this term.

    def search_venues_by_tip(options={})
      tips = search_tips(options)
      venues = []
      tips.each do |tip|
        venues << tip['venue']
      end
      venues
    end

    # Retrieve information about all venue categories.

    def venue_categories
      response = connection.get("venues/categories")
      return_error_or_body(response, response.body.response.categories)
    end

    # Retrieve links for a venue.
    #
    # param [String] venue_id The ID of the venue

    def venue_links(venue_id)
      response = connection.get("venues/#{venue_id}/links")
      return_error_or_body(response, response.body.response.links)
    end

    # Add a venue
    # @param [Hash]  options
    # @option options String :name - Name of the venue (required)
    # @option options String :address
    # @option options String :crossStreet
    # @option options String :city
    # @option options String :state
    # @option options String :zip
    # @option options String :phone
    # @option options String :ll - Latitude and longitude in format LAT,LON
    # @option options String :primaryCategoryId - Main category for the venue, must be in the list of venue categories.

    def add_venue(options={})
      response = connection.post do |req|
        req.url "venues/add", options
      end
      return_error_or_body(response, response.body.response.venue)
    end

    # Mark a venue as todo for the authenticated user
    #
    # @param [String] venue_id - Venue id to mark todo, required.
    # @param [Hash] options
    # @option options String :text - Text for the tip/todo

    def mark_venue_todo(venue_id, options={})
      response = connection.post do |req|
        req.url "venues/#{venue_id}/marktodo", options
      end
      return_error_or_body(response, response.body.response)
    end

    # Flag a venue as having a problem
    #
    # @param [String] venue_id - Venue id to flag, required.
    # @param [Hash] options
    # @option options String :problem - Reason for flag, one of mislocated,closed, or duplicate.  Required.

    def flag_venue(venue_id, options={})
      response = connection.post do |req|
        req.url "venues/#{venue_id}/flag", options
      end
      return_error_or_body(response, response.body.response)
    end

    # Propose a venue edit
    # @param [String] venue_id - Venue id to propose edit for, required.
    # @param [Hash]  options
    # @option options String :name - Name of the venue (required)
    # @option options String :address
    # @option options String :crossStreet
    # @option options String :city
    # @option options String :state
    # @option options String :zip
    # @option options String :phone
    # @option options String :ll - Latitude and longitude in format LAT,LON
    # @option options String :primaryCategoryId - Main category for the venue, must be in the list of venue categories.

    def propose_venue_edit(venue_id, options={})
      response = connection.post do |req|
        req.url "venues/#{venue_id}/proposeedit", options
      end
      return_error_or_body(response, response.body.response)
    end

    # Explore venues
    #
    # @param [Hash]  options
    # @option options String :ll - Latitude and longitude in format LAT,LON
    # @option options Integer :llAcc - Accuracy of the lat/lon in meters.
    # @option options Integer :alt - Altitude in meters
    # @option options Integer :altAcc - Accuracy of the altitude in meters
    # @option options Integer :radius - Radius to search within, in meters
    # @option options String :section - One of food, drinks, coffee, shops, or arts. Choosing one of these limits results to venues with categories matching these terms.
    # @option options String :query - Query to match venues on.
    # @option options Integer :limit - The limit of results to return.
    # @option options String :intent - Limit results to venues with specials.
    # @option options String :novelty - Pass new or old to limit results to places the acting user hasn't been or has been, respectively. Omitting this parameter returns a mixture.

    def explore_venues(options={})
      response = connection.get do |req|
        req.url "venues/explore", options
      end
      return_error_or_body(response, response.body.response)
    end

    # Suggest venue completions. Returns a list of mini-venues partially matching the search term, near the location.
    #
    # @param [Hash]  options
    # @option options String :ll - Latitude and longitude in format LAT,LON
    # @option options Integer :llAcc - Accuracy of the lat/lon in meters.
    # @option options Integer :alt - Altitude in meters
    # @option options Integer :altAcc - Accuracy of the altitude in meters
    # @option options String :query - Query to match venues on.
    # @option options Integer :limit - The limit of results to return.

    def suggest_completion_venues(options={})
      response = connection.get do |req|
        req.url "venues/suggestCompletion", options
      end
      return_error_or_body(response, response.body.response)
    end

    # Retrieve menus for a venue.
    #
    # param [String] venue_id The ID of the venue

    def venue_menus(venue_id)
      response = connection.get("venues/#{venue_id}/menu")
      return_error_or_body(response, response.body.response)
    end

    # Returns a list of users that are currently checked into a venue
    #
    # param [String] venue_id The ID of the venue managed by the current user
    # @param [Hash] options
    # @option options Integer :limit - Number of results to return, up to 500.
    # @option options Integer :offset - Used to page through results.
    # @option options Integer :afterTimestamp - Retrieve the first results to follow these seconds since epoch.

    def herenow(venue_id, options={})
      response = connection.get do |req|
        req.url "venues/#{venue_id}/herenow", options
      end
      return_error_or_body(response, response.body.response)
    end

    #
    #Returns a list of venues managed
    #

    def managed_venues()
      response = connection.get do |req|
        req.url "venues/managed"
      end
      return_error_or_body(response, response.body.response.venues)
    end

    # Get venue stats over a given time range. Client instance should represent an OAuth user who is the venue owner.
    # Note: returns more detailed statistics than the basic stats returned when calling venue(venue_id)
    #
    # param [String] venue_id The ID of the venue managed by the current user
    # @param [Hash] options
    # @option options Integer :startAt - The start of the time range to retrieve stats for (seconds since epoch). If omitted, all-time stats will be returned.
    # @option options Integer :endAt - The end of the time range to retrieve stats for (seconds since epoch). If omitted, the current time is assumed.

    def managed_venue_stats(venue_id, options={})
      response = connection.get do |req|
        req.url "venues/#{venue_id}/stats", options
      end
      return_error_or_body(response, response.body.response)
    end

    # Get daily venue stats for a list of venues over a time range.
    # Client instance should represent an OAuth user who is the venues owner.
    #
    # @param [Hash] options
    # @option options Array[String] :venueId - A list of venue ids to retrieve series data for.
    # @option options Integer :startAt - Required. The start of the time range to retrieve stats for (seconds since epoch).
    # @option options Integer :endAt - The end of the time range to retrieve stats for (seconds since epoch). If omitted, the current time is assumed.
    # @option options String :fields - Specifies which fields to return. May be one or more of totalCheckins, newCheckins, uniqueVisitors, sharing, genders, ages, hours, separated by commas.

    def venues_timeseries(options={})
      options[:venueId] = options[:venueId].join(',') # Transforms the array into a 'comma-separated list' of ids.
      response = connection.get do |req|
        req.url "venues/timeseries", options
      end
      return_error_or_body(response, response.body.response)
    end
  end
end
