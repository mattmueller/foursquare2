require 'helper'

class TestTips < Test::Unit::TestCase

  context "When using the foursquare API and working with tips" do
    setup do
      @client = foursquare_test_client
    end

    should "fetch info for a single tip" do
      stub_get("https://api.foursquare.com/v2/tips/4b5e662a70c603bba7d790b4?oauth_token=#{@client.oauth_token}", "tips/tip.json")
      tip = @client.tip('4b5e662a70c603bba7d790b4')
      tip.done.groups.first['count'].should == 0
      tip.done.groups.last['count'].should == 6
      tip.done.groups.last.items.first.firstName.should == 'Allison'
      tip.venue.name.should == '2 Bros Pizza'
    end

    should "fetch results when searching for nearby tips" do
      stub_get("https://api.foursquare.com/v2/tips/search?ll=40.7%2C-73.9&oauth_token=#{@client.oauth_token}&limit=3", "tips/search_tips.json")
      tips = @client.search_tips(:ll => '40.7,-73.9', :limit => 3)
      tips.count.should == 3
      tips.first.text.should == "If you want a soda go to the vending machine next to the ice Cream place near the music barge it's only $2 for a 20oz bottle instead of $2 for a can at one of the carts."
    end
  end
end
