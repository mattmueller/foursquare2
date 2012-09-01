module Foursquare2
  module Events

    # Retrieve information about an event
    #
    # param [String] event_id The ID of the event

    def event(event_id)
      response = connection.get("events/#{event_id}")
      return_error_or_body(response, response.body.response.event)
    end

    # Retrieve information about all event categories.

    def event_categories
      response = connection.get("events/categories")
      return_error_or_body(response, response.body.response.categories)
    end

  end
end
