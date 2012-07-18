module Foursquare2
  module Lists

    # Retrieve information about a list.
    #
    # @param [String] list_id - The id of the list to retrieve.
    # @param [Hash] options
    # @option options Integer :limit - Number of results to return, up to 200.
    # @option options Integer :offset - The number of results to skip. Used to page through results.

    def list(list_id, options={})
      response = connection.get do |req|
        req.url "lists/#{list_id}", options
      end
      return_error_or_body(response, response.body.response.list)
    end

    # Add a list: See https://developer.foursquare.com/docs/lists/add
    #
    # @param [Hash]  options
    # @option options String :name - (required) The name of the list
    # @option options String :description - The description of the list.
    # @option options Boolean :collaborative - Boolean indicating if this list can be edited by friends.
    # @option options String :photoId - The id of a photo that should be set as the list photo.

    def add_list(options={})
      response = connection.post do |req|
        req.url "lists/add", options
      end
        return_error_or_body(response, response.body.response.list)
    end

    # Update a list: https://developer.foursquare.com/docs/lists/update
    #
    # @param [String] list_id - The id of the list to update
    # @param [Hash] options
    # @option options String :name - The name of the list
    # @option options String :description - The description of the list.
    # @option options Boolean :collaborative - Boolean indicating if this list can be edited by friends.
    # @option options String :photoId - The id of a photo that should be set as the list photo.

    def update_list(list_id, options={})
      response = connection.post do |req|
        req.url "lists/#{list_id}/update", options
      end
        return_error_or_body(response, response.body.response.list)
    end

  end
end
