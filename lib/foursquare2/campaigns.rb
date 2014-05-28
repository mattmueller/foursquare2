module Foursquare2
  module Campaigns

    # Retrieve information about a campaign
    #
    # param [String] campaign_id The ID of the venue
    def campaign(campaign_id, options={})
      response = connection.get do |req|
        req.url "campaigns/#{campaign_id}", options
      end
      return_error_or_body(response, response.body.response.campaign)
    end

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

    # Get a list of campaigns
    # Details on param options can be found at https://developer.foursquare.com/docs/campaigns/list
    #
    # @param [Hash]  options
    # @option options String :specialId - if specified, limits response to campaigns involving the given special
    # @option options String :groupId - if specified, limits response to campaigns involving the given group
    # @option options String :status - which campaigns to return: pending,scheduled,active,expired,depleted,stopped,notStarted,ended,all (default=all)
    #
    #

    def list_campaigns(options={})
      response = connection.get do |req|
        req.url "campaigns/list", options
      end
        return_error_or_body(response, response.body.response.campaigns.items)
    end

    # End a campaign
    # Details on param can be found at https://developer.foursquare.com/docs/campaigns/end
    #
    # @campaign_id String :campaignId - The ID of the campaign to end. Must be specified. Pass in as a string and not as a hash.
    #
    #

    def end_campaign(campaign_id, options={})
      response = connection.post do |req|
        req.url "campaigns/#{campaign_id}/end", options
      end
        return_error_or_body(response, response.body.code)
    end

  end
end
