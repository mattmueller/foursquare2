module Foursquare2
  module Venuegroups

    # Retrieve information about a venuegroup
    #
    # param [String] venuegroup_id The ID of the venue

    def venue(venuegroup_id)
      response = connection.get("venuegroups/#{venuegroup_id}")
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