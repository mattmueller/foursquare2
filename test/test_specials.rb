require 'helper'

class TestSpecials < Test::Unit::TestCase

  context "When using the foursquare API and working with specials" do
    setup do
      @client = foursquare_test_client
    end

    should "fetch info for a single special" do
      stub_get("https://api.foursquare.com/v2/specials/4bd876f886ba62b58a6e88b3?oauth_token=#{@client.oauth_token}", "special.json")
      special = @client.special('4bd876f886ba62b58a6e88b3')
      special.message.should == "$10 off for the mayor!"
    end

    should "fetch results when searching for nearby specials" do
      stub_get("https://api.foursquare.com/v2/specials/search?ll=40.7%2C-73.9&oauth_token=#{@client.oauth_token}", "search_specials.json")
      specials = @client.search_specials(:ll => '40.7,-73.9')
      specials.count.should == 1
      specials.first.message.should == "Buy 1 Get 1 40% Off All Video Games (priced up to $19.99)\r\n\r\nItems must be of equal or lesser value to the lowest priced item purchased\r\n\r\nEnds 2/12/2011"
    end
  end
end
