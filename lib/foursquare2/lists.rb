module Foursquare2
  module Lists

    # Retrieve information about a list.
    #
    # param [String] list_id - The id of the list to retrieve.
    # param [Hash] options
    # @option options Integer :limit - Number of results to return, up to 200.
    # @option options Integer :offset - The number of results to skip. Used to page through results.

    def list(list_id, options={})
      response = connection.get do |req|
        req.url "lists/#{list_id}", options
      end
      return_error_or_body(response, response.body.response.list)
    end

  end
end
