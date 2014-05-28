module Foursquare2
  module Venuegroups

    # Retrieve information about a venuegroup
    #
    # param [String] group_id The ID of the venuegroup

    def venuegroup(group_id, options={})
      response = connection.get do |req|
        req.url "venuegroups/#{group_id}", options
      end
      return_error_or_body(response, response.body.response.venueGroup)
    end

    # Create a venue group. If the venueId parameter is specified,
    # then the endpoint will add the specified venues to the venue group.
    # If it is not possible to add all of the specified venues to the group,
    # then creation of the venue group will fail entirely.
    # @param [Hash]  options
    # @option options String :name - Required. The name to give the group.
    # @option options String :venueId - Comma-delimited list of venue IDs to add to the group. If this parameter is not specified, then the venue group will initially be empty.

    def add_venuegroup(options={})
      response = connection.post do |req|
        req.url "venuegroups/add", options
      end
      return_error_or_body(response, response.body.response.venueGroup)
    end

    # Updates a venue group. At least one of the name and venueId parameters must be specified.
    # @param [String] group_id - required The ID of the venue group to modify
    # @param [Hash]  options
    # @option options String :name - If specified, the new name to give to the group.
    # @option options String :venueId - If specified, a comma-delimited list of venue IDs that will become the new set of venue IDs for the group.


    def venuegroup_update(group_id, options={})
      response = connection.post do |req|
        req.url "venuegroups/#{group_id}/update", options
      end
      return_error_or_body(response, response.body.response.venueGroup)
    end

    # List all venue groups owned by the user.

    def list_venuegroup(options={})
      response = connection.get do |req|
        req.url "venuegroups/list", options
      end
      return_error_or_body(response, response.body.response.venueGroups)
    end

    # Delete a venue group.
    # param [String] group_id - The ID of the venuegroup to delete.

    def delete_venuegroup(group_id, options={})
      response = connection.post do |req|
        req.url "venuegroups/#{group_id}/delete", options
      end
      return_error_or_body(response, response.body.response)
    end
  end
end