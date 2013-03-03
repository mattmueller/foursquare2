require 'helper'

class TestCampaigns < Test::Unit::TestCase

  context "When using the foursquare API and working with campaigns" do
    setup do
      @client = foursquare_test_client
    end
    
    should "add a campaign" do
      stub_post("https://api.foursquare.com/v2/campaigns/add?oauth_token=#{@client.oauth_token}&specialId=4bd876f886ba62b58a6e88b3", "campaigns/campaign_created.json")
      campaign = @client.add_campaign(:specialId => '4bd876f886ba62b58a6e88b3')
      campaign.special.id == "4bd876f886ba62b58a6e88b3"
    end

    should "list all campaigns" do
      stub_post("https://api.foursquare.com/v2/campaigns/add?oauth_token=#{@client.oauth_token}&specialId=4bd876f886ba62b58a6e88b3", "campaigns/campaigns_list.json")
      campaigns = @client.list_campaigns(:status => 'active')
      campaigns.first.id == "4e0deba2922e6f94b1410b79"
    end

    should "list campaigns of specialId" do
      stub_post("https://api.foursquare.com/v2/campaigns/add?oauth_token=#{@client.oauth_token}&specialId=4bd876f886ba62b58a6e88b3", "campaigns/campaigns_list.json")
      campaigns = @client.list_campaigns(:specialId => '4e0debea922e6f94b1410bb7')
      campaigns.special.id == "4e0debea922e6f94b1410bb7"
    end

  end
end