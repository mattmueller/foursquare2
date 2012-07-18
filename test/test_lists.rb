require 'helper'

class TestLists < Test::Unit::TestCase

  context "When using the foursquare API and working with lists" do
    setup do
      @client = foursquare_test_client
      @list_id = '4f230d90e4b0b653a21ffd0d'
    end

    should "fetch info for a single list" do
      stub_get("https://api.foursquare.com/v2/lists/#{@list_id}?oauth_token=#{@client.oauth_token}", "list.json")
      list = @client.list(@list_id)
      list.name.should == 'Restaurants to Try'
      list.venueCount.should == 8
    end

    should "add a list" do
      stub_post("https://api.foursquare.com/v2/lists/add?oauth_token=#{@client.oauth_token}&name=Ramen+Spots", "list_created.json")
      list = @client.add_list(:name => "Ramen Spots")
      list.name.should == "Ramen Spots"
    end

    should "update a list" do
      stub_post("https://api.foursquare.com/v2/lists/#{@list_id}/update?oauth_token=#{@client.oauth_token}&name=Ramen+Sports", "list_updated.json")
      list = @client.update_list(@list_id, :name => "Ramen Sports")
      list.name.should == "Ramen Sports"
    end

    should "add an item to a list" do
      venue_id = '4ba19cb0f964a520c2c337e3'
      stub_post("https://api.foursquare.com/v2/lists/#{@list_id}/additem?oauth_token=#{@client.oauth_token}&venueId=#{venue_id}", "list_item.json")
      item = @client.add_list_item(@list_id, :venueId => venue_id)
      item.venue.id.should == venue_id
    end

    should "delete an item from a list" do
      item_id = 'v4ba19cb0f964a520c2c337e3'
      stub_post("https://api.foursquare.com/v2/lists/#{@list_id}/deleteitem?oauth_token=#{@client.oauth_token}&itemId=#{item_id}", "list_item.json")
      item = @client.delete_list_item(@list_id, item_id)
      item.id.should == item_id
    end
  end
end
