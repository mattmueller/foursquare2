module Foursquare2
  module Campaigns
    
    # Add a campaign 
    # Details on param options can be found at https://developer.foursquare.com/docs/campaigns/add
    #
    # @param [Hash]  options
    # @option options String :specialId - required (unless the campaignId parameter has been provided). special ID
    # @option options String :groupId - comma-separated list of venue group IDs (either groupId or venueId is required)
    # @option options String :venueId - comma-separated list of venue IDs (either groupId or venueId is required)
    # @option options Integer :endAt - DateTime when the campaign is to be automatically deactivated (seconds since epoch)
    # @option options Integer :startAt - DateTime when the campaign is to be started (seconds since epoch)
    # @option options String :campaignId - ID of an existing campaign to copy. 
    #

    def add_campaign(options={})
      response = connection.post do |req|
        req.url "campaigns/add", options
      end
        return_error_or_body(response, response.body.response.campaign)
    end
    
  end
end
