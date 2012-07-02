module Foursquare2
  module Pages

    # Get information about a page.
    #
    # /!\ A page is considered by Foursquare as a user.
    # @param [Integer] user_id - Page to get information for.

    def page(user_id)
      response = connection.get("pages/#{user_id}")
      return_error_or_body(response, response.body.response.user)
    end


    # Search for pages.
    #
    # @param [Hash]  options
    # @option options String :twitter - Match on twitter username
    # @option options String :fbid - Match on facebook id.
    # @option options String :name - Match on name

    def search_pages(options={})
      response = connection.get do |req|
        req.url "pages/search", options
      end
      return_error_or_body(response, response.body.response)
    end


    # Get all venues for a given page.
    #
    # @param [String] page_id - The page to retrieve venues for.
    # @param [Hash]  options
    # @option options Integer :limit
    # @option options Integer :offset - For paging through results
    # @option options String :ll - Latitude and longitude in format LAT,LON - Limit results to venues near this latitude and longitude. NOT VALID with NE or SW (see after).
    # @option String :radius - Can be used when including ll. Limit results to venues within this many meters of the specified ll. Not valid with ne or sw.
    # @option String :sw - With ne, limits results to the bounding quadrangle defined by the latitude and longitude given by sw as its south-west corner, and ne as its north-east corner. Not valid with ll or radius. 
    # @option String :ne - See sw
    
    def page_venues(page_id, options={})
      response = connection.get do |req|
        req.url "pages/#{page_id}/venues", options
      end
      venues = return_error_or_body(response, response.body.response.venues)
      venues = Foursquare2.filter(venues, options[:query]) if options.has_key? :query
      venues
    end
  end
end