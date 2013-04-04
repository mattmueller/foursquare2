require 'helper'

class TestVenuegroups < Test::Unit::TestCase

  context "When using the foursquare API and working with venuegroups" do
    setup do
      @client = foursquare_test_client
    end

    should "get a venuegroup" do
      stub_post("https://api.foursquare.com/v2/venuegroups/4e15cd13b61c42e7c54e5bb6?oauth_token=#{@client.oauth_token}", "venuegroups/venuegroup.json")
      venuegroup = @client.venuegroup('4e15cd13b61c42e7c54e5bb6')
      venuegroup.id == "4e15cd13b61c42e7c54e5bb6"
    end

    should "update a venuegroup" do
      stub_post("https://api.foursquare.com/v2/venuegroups/4e15cd13b61c42e7c54e5bb6/update?oauth_token=#{@client.oauth_token}?venueId=4b8c3d87f964a520f7c532e3,4d572bcc9e508cfab975189b", "venuegroups/venuegroup_update.json")
      venuegroup = @client.venuegroup('4e15cd13b61c42e7c54e5bb6')
      venuegroup.venues.count == 2
    end

  end
end