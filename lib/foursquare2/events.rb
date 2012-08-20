module Foursquare2
  module Events

    # Retrieve information about all event categories.

    def event_categories
      response = connection.get("events/categories")
      return_error_or_body(response, response.body.response.categories)
    end

  end
end
