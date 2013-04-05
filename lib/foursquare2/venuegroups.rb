module Foursquare2
  module Venuegroups

    # Retrieve information about a venuegroup
    #
    # param [String] group_id The ID of the venuegroup

    def venuegroup(group_id)
      response = connection.get("venuegroups/#{group_id}")
      return_error_or_body(response, response.body.response.venuegroup)
    end

    # Add a venuegroup
    # @option options String :name - Required
    # @option options String :venueId - If specified, a comma-delimited list of venue IDs that will become the new set of venue IDs for the group.

    def add_venuegroup(options={})
      response = connection.post do |req|
        req.url "venuegroups/add", options
      end
      return_error_or_body(response, response.body.response.venuegroup)
    end

    # Update a venuegroup
    # @param [String] group_id - The Id of the venuegroup you're updating (required)
    # @param [Hash]  options
    # @option options String :name
    # @option options String :venueId - If specified, a comma-delimited list of venue IDs that will become the new set of venue IDs for the group.

    def venuegroup_update(group_id, options={})
      response = connection.post do |req|
        req.url "venuegroups/#{group_id}/update", options
      end
      return_error_or_body(response, response.body.response.venuegroup)
    end
  end
end