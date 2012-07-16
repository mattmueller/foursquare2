require 'helper'

class TestLists < Test::Unit::TestCase

  context "When using the foursquare API and working with lists" do
    setup do
      @client = foursquare_test_client
    end

    should "fetch info for a single list" do
      stub_get("https://api.foursquare.com/v2/lists/4f230d90e4b0b653a21ffd0d?oauth_token=#{@client.oauth_token}", "list.json")
      list = @client.list('4f230d90e4b0b653a21ffd0d')
      list.name.should == 'Restaurants to Try'
      list.venueCount.should == 8
    end

    should "add a list" do
      stub_post("https://api.foursquare.com/v2/lists/add?oauth_token=#{@client.oauth_token}&name=Ramen+Spots", "list_created.json")
      list = @client.add_list(:name => "Ramen Spots")
      list.name.should == "Ramen Spots"
    end

  end
end
