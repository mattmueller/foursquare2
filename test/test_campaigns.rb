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
    
  end
end