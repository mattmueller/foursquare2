require 'helper'

class TestVenues < Test::Unit::TestCase

  context "When using the foursquare API and working with venues" do
    setup do
      @client = foursquare_test_client
    end

    should "fetch info for a single venue" do
      stub_get("https://api.foursquare.com/v2/venues/4b8c3d87f964a520f7c532e3?oauth_token=#{@client.oauth_token}", "venue.json")
      venue = @client.venue('4b8c3d87f964a520f7c532e3')
      venue.name.should == 'Bridgestone Arena'
      venue.location.address.should == '501 Broadway'
    end

    should "search for venues based on passed criteria" do
      stub_get("https://api.foursquare.com/v2/venues/search?ll=36.142064%2C-86.816086&oauth_token=#{@client.oauth_token}&query=coffee", "search_venues.json")
      venues = @client.search_venues(:ll => "36.142064,-86.816086", :query => "coffee")
      venues.groups.first.items.first.name.should == 'Ugly Mugs'
    end

    should "search for venues from a tip search" do
      stub_get("https://api.foursquare.com/v2/tips/search?ll=-23.013968%2C-45.550802&oauth_token=#{@client.oauth_token}&query=rodoviaria", "search_venues_by_tip.json")
      venues = @client.search_venues_by_tip(:ll => "-23.013968,-45.550802", :query => "rodoviaria")
      venues.first.name.should == "Santa Barbara"
    end

    should "not find venues from a tip search" do
      stub_get("https://api.foursquare.com/v2/tips/search?ll=-23.013968%2C-45.550802&oauth_token=#{@client.oauth_token}&query=loremlpsun", "no_venues_by_tip.json")
      venues = @client.search_venues_by_tip(:ll => "-23.013968,-45.550802", :query => "loremlpsun")
      venues.size.should == 0
    end

    should "get tips from a venue" do
      stub_get("https://api.foursquare.com/v2/venues/4b8c3d87f964a520f7c532e3/tips?oauth_token=#{@client.oauth_token}", "venue_tips.json")
      tips = @client.venue_tips('4b8c3d87f964a520f7c532e3')
      tips.items.first.id.should == "4c94a45c82b56dcb47cad0aa"
      tips.items.size.should == 4
    end

    should "get tips from a venue only with some term" do
      stub_get("https://api.foursquare.com/v2/venues/4c94a45c82b56dcb47cad0aa/tips?oauth_token=#{@client.oauth_token}", "venue_tips.json")
      tips = @client.venue_tips('4c94a45c82b56dcb47cad0aa', {:query => "legal"})
      tips.items.count.should == 1
      tips.items.first.id.should == "4c94a45c82b56dcb47cad0aa"
    end

    should "get tips from a venue only with some term case sensitive" do
      stub_get("https://api.foursquare.com/v2/venues/4c94a45c82b56dcb47cad0aa/tips?oauth_token=#{@client.oauth_token}", "venue_tips.json")
      tips = @client.venue_tips('4c94a45c82b56dcb47cad0aa', {:query => "LEGAL"})
      tips.items.count.should == 1
      tips.items.first.id.should == "4c94a45c82b56dcb47cad0aa"
    end

    should "no tips from a venue with term lorem" do
      stub_get("https://api.foursquare.com/v2/venues/4c94a45c82b56dcb47cad0aa/tips?oauth_token=#{@client.oauth_token}", "venue_tips.json")
      tips = @client.venue_tips('4c94a45c82b56dcb47cad0aa', {:query => "lorem"})

      tips.items.count.should == 0
    end
    
    should "allow venues to be explored" do
      stub_get("https://api.foursquare.com/v2/venues/explore?section=food&ll=40.7%2C-74&oauth_token=yeehaw&limit=2", "explore_venues.json")
      venues = @client.explore_venues(:ll => '40.7,-74', :section => 'food', :limit => '2')
      venues.groups.first.items.count.should == 2
    end
     

  end

end
