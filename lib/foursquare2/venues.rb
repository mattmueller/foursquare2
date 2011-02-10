module Foursquare2
  module Venues

    def venue(venue_id)
      response = connection.get("venues/#{venue_id}")
      return_error_or_body(response, response.body.response.venue)
    end

    def search_venues(options={})
      response = connection.get do |req|
        req.url "venues/search", options
      end
      return_error_or_body(response, response.body.response)
    end

    def venue_categories
      response = connection.get("venues/categories")
      return_error_or_body(response, response.body.response.categories)
    end

    def add_venue(options={})
      response = connection.post do |req|
        req.url "venues/add", options
      end
      return_error_or_body(response, response.body.response.venue)
    end

    def mark_venue_todo(venue_id, options={})
      response = connection.post do |req|
        req.url "venues/#{venue_id}/marktodo", options
      end
      return_error_or_body(response, response.body.response)
    end

    def flag_venue(venue_id, options={})
      response = connection.post do |req|
        req.url "venues/#{venue_id}/flag", options
      end
      return_error_or_body(response, response.body.response)
    end

    def propose_venue_edit(venue_id, options={})
      response = connection.post do |req|
        req.url "venues/#{venue_id}/proposeedit", options
      end
      return_error_or_body(response, response.body.response)
    end
  end 
end
