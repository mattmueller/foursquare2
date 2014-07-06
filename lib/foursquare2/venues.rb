module Foursquare2
  module Venues

    # Retrieve information about a venue
    #
    # param [String] venue_id The ID of the venue

    def venue(venue_id, options={})
      response = connection.get do |req|
        req.url "venues/#{venue_id}", options
      end
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

    def venue_categories(options={})
      response = connection.get do |req|
        req.url "venues/categories", options
      end
      return_error_or_body(response, response.body.response.categories)
    end

    # Retrieve links for a venue.
    #
    # param [String] venue_id The ID of the venue

    def venue_links(venue_id, options={})
      response = connection.get do |req|
        req.url "venues/#{venue_id}/links", options
      end
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

    # Make changes to a venue
    # @param [String] venue_id - Venue id to edit, required. Acting user must be a venue manager or a superuser.
    # @param [Hash]  options
    # @option options String :name
    # @option options String :address
    # @option options String :crossStreet
    # @option options String :city
    # @option options String :state
    # @option options String :zip
    # @option options String :phone
    # @option options String :ll - Latitude and longitude in format LAT,LON
    # @option options String :categoryId - The IDs of the category or categories to which you want to assign this venue (separate multiple IDs with commas).
    # @option options String :twitter – Twitter handle of the name.
    # @option options String :description – A free-form venue description, up to 300 characters.
    # @option options String :url – The url of the homepage of the venue.
    # @option options String :storeId – An identifier used by the manager of the venue to distinguish between venues of the same name. Only visible to managers.
    # @option options String :hours – The hours for the venue, as a semi-colon separated list of open segments and named segments.

    def edit_venue(venue_id, options={})
      response = connection.post do |req|
        req.body = options
        req.url "venues/#{venue_id}/proposeedit"
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
    # @option options String :venuePhotos - true to bring out the photos
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

    def venue_menus(venue_id, options={})
      response = connection.get do |req|
        req.url "venues/#{venue_id}/menu", options
      end
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

    def managed_venues(options={})
      response = connection.get do |req|
        req.url "venues/managed", options
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

    # Get venue hours information.
    #
    # param [String] venue_id The ID of the venue

    def venue_hours(venue_id, options={})
      response = connection.get do |req|
        req.url "venues/#{venue_id}/hours", options
      end
      return_error_or_body(response, response.body.response)
    end

    # Get the events currently taking place at a venue.
    #
    # param [String] venue_id The ID of the venue

    def venue_events(venue_id, options={})
      response = connection.get do |req|
        req.url "venues/#{venue_id}/events", options
      end
      return_error_or_body(response, response.body.response)
    end

    # Returns friends and a total count of users who have liked this venue.
    #
    # param [String] venue_id The ID of the venue to get likes for

    def venue_likes(venue_id, options={})
      response = connection.get do |req|
        req.url "venues/#{venue_id}/likes", options
      end
      return_error_or_body(response, response.body.response)
    end

    # Returns the lists that this venue appears on.
    #
    # param [String] venue_id ID of a venue to get lists for.
    # @option options String :group - can be created, edited, followed, friends, other. If no acting user is present, only other is supported.
    # @option options Integer :limit - Number of results to return, up to 200.
    # @option options Integer :offset - Used to page through results. Must specify a group

    def venue_listed(venue_id, options={})
      response = connection.get do |req|
        req.url "venues/#{venue_id}/listed", options
      end
      return_error_or_body(response, response.body.response)
    end

    # Returns venues that people often check in to after the current venue. Up to 5 venues are returned in each query, and results are sorted by how many people have visited that venue after the current one. Homes are never returned in results.
    #
    # param [String] venue_id Required. ID of the venue you want to see next venue information about

    def venue_nextvenues(venue_id, options={})
      response = connection.get do |req|
        req.url "venues/#{venue_id}/nextvenues", options
      end
      return_error_or_body(response, response.body.response)
    end

    # Returns a list of venues similar to the specified venue.
    #
    # param [String] venue_id The venue you want similar venues for.

    def venue_similar(venue_id, options={})
      response = connection.get do |req|
        req.url "venues/#{venue_id}/similar", options
      end
      return_error_or_body(response, response.body.response)
    end
  end
end
