module Foursquare2
  module Events

    # Retrieve information about an event
    #
    # param [String] event_id The ID of the event

    def event(event_id, options={})
      response = connection.get do |req|
        req.url "events/#{event_id}", options
      end
      return_error_or_body(response, response.body.response.event)
    end

    # Retrieve information about all event categories.

    def event_categories(options={})
      response = connection.get do |req|
        req.url "events/categories", options
      end
      return_error_or_body(response, response.body.response.categories)
    end

  end
end
