require 'helper'

class TestVenues < Test::Unit::TestCase

  context "When using the foursquare API and working with venues" do
    setup do
      @client = foursquare_test_client
    end

    should "fetch info for a single venue" do
      stub_get("https://api.foursquare.com/v2/venues/4b8c3d87f964a520f7c532e3?oauth_token=#{@client.oauth_token}", "venues/venue.json")
      venue = @client.venue('4b8c3d87f964a520f7c532e3')
      venue.name.should == 'Bridgestone Arena'
      venue.location.address.should == '501 Broadway'
    end

    should "search for venues based on passed criteria" do
      stub_get("https://api.foursquare.com/v2/venues/search?ll=36.142064%2C-86.816086&oauth_token=#{@client.oauth_token}&query=coffee", "venues/search_venues.json")
      venues = @client.search_venues(:ll => "36.142064,-86.816086", :query => "coffee")
      venues.groups.first.items.first.name.should == 'Ugly Mugs'
    end
    
    should "search for trending venues around a certain position" do
      stub_get("https://api.foursquare.com/v2/venues/trending?ll=36.132832%2C-115.151827&radius=10000&oauth_token=#{@client.oauth_token}", "venues/trending_venues.json")
      venues = @client.trending_venues("36.132832,-115.151827", { :radius => 10000 })
      
      venues.venues.count.should == 2
      venues.venues.first.name == "McCarran International Airport (LAS)"
    end

    should "search for venues from a tip search" do
      stub_get("https://api.foursquare.com/v2/tips/search?ll=-23.013968%2C-45.550802&oauth_token=#{@client.oauth_token}&query=rodoviaria", "venues/search_venues_by_tip.json")
      venues = @client.search_venues_by_tip(:ll => "-23.013968,-45.550802", :query => "rodoviaria")
      venues.first.name.should == "Santa Barbara"
    end

    should "not find venues from a tip search" do
      stub_get("https://api.foursquare.com/v2/tips/search?ll=-23.013968%2C-45.550802&oauth_token=#{@client.oauth_token}&query=loremlpsun", "venues/no_venues_by_tip.json")
      venues = @client.search_venues_by_tip(:ll => "-23.013968,-45.550802", :query => "loremlpsun")
      venues.size.should == 0
    end

    should "get tips from a venue" do
      stub_get("https://api.foursquare.com/v2/venues/4b8c3d87f964a520f7c532e3/tips?oauth_token=#{@client.oauth_token}", "venues/venue_tips.json")
      tips = @client.venue_tips('4b8c3d87f964a520f7c532e3')
      tips.items.first.id.should == "4c94a45c82b56dcb47cad0aa"
      tips.items.size.should == 4
    end

    should "get tips from a venue only with some term" do
      stub_get("https://api.foursquare.com/v2/venues/4c94a45c82b56dcb47cad0aa/tips?oauth_token=#{@client.oauth_token}", "venues/venue_tips.json")
      tips = @client.venue_tips('4c94a45c82b56dcb47cad0aa', {:query => "legal"})
      tips[:count].should == 1
      tips.items.first.id.should == "4c94a45c82b56dcb47cad0aa"
    end

    should "get tips from a venue only with some term case sensitive" do
      stub_get("https://api.foursquare.com/v2/venues/4c94a45c82b56dcb47cad0aa/tips?oauth_token=#{@client.oauth_token}", "venues/venue_tips.json")
      tips = @client.venue_tips('4c94a45c82b56dcb47cad0aa', {:query => "LEGAL"})

      tips.items.size.should == 1
      tips.items.first.id.should == "4c94a45c82b56dcb47cad0aa"
    end

    should "no tips from a venue with term lorem" do
      stub_get("https://api.foursquare.com/v2/venues/4c94a45c82b56dcb47cad0aa/tips?oauth_token=#{@client.oauth_token}", "venues/venue_tips.json")
      tips = @client.venue_tips('4c94a45c82b56dcb47cad0aa', {:query => "lorem"})

      tips[:items].size.should == 0
    end

    should "allow venues to be explored" do
      stub_get("https://api.foursquare.com/v2/venues/explore?section=food&ll=40.7%2C-74&oauth_token=#{@client.oauth_token}&limit=2", "venues/explore_venues.json")
      venues = @client.explore_venues(:ll => '40.7,-74', :section => 'food', :limit => '2')
      venues.groups.first.items.count.should == 2
    end

    should "allow venues to be edited" do
      stub_post("https://api.foursquare.com/v2/venues/4b9d65a8f964a520b0a936e3/proposeedit?oauth_token=#{@client.oauth_token}", "venues/edit_venue.json")
      edited_venue = @client.edit_venue("4b9d65a8f964a520b0a936e3", :v => '20140706', :phone => '9043212111')
      edited_venue.woes.first.currentValue.should == "(904) 321-2111"
    end

    should "get links for a venue" do
      stub_get("https://api.foursquare.com/v2/venues/4b8c3d87f964a520f7c532e3/links?oauth_token=#{@client.oauth_token}", "venues/venue_links.json")
      links = @client.venue_links('4b8c3d87f964a520f7c532e3')
      links.items.first.linkedId.should == "2513467"
      links.items.size == links.count
      links.items.size.should == 2
    end

    should "get photos for a venue" do
      stub_get("https://api.foursquare.com/v2/venues/4b8c3d87f964a520f7c532e3/photos?group=venue&oauth_token=#{@client.oauth_token}&limit=3", "venues/venue_photos.json")
      photos = @client.venue_photos('4b8c3d87f964a520f7c532e3', { :group => 'venue', :limit => 3 })
      photos.items.first.id.should == "4edc309e46907c1b44d25ab2"
      photos['count'].should == 222
      photos.items.size.should == 3
    end

    should "should suggest venues based on passed criteria" do
      stub_get("https://api.foursquare.com/v2/venues/suggestCompletion?oauth_token=#{@client.oauth_token}&ll=40.7%2C-74&query=coffee", "venues/suggest_completion_venues.json")
      venues = @client.suggest_completion_venues(:ll => "40.7,-74", :query => "coffee")
      venues.minivenues.first.id.should == '44dc96e4f964a520b0361fe3'
    end

    should "fetch venue for manager" do
      stub_get("https://api.foursquare.com/v2/venues/managed?oauth_token=#{@client.oauth_token}", "venues/managed_venues.json")
      venues = @client.managed_venues()
      venues.first.name.should == 'Black Founders Startup Ventures'
      venues.first.location.address.should == '625 2nd St'
    end

    should "get menus for a venue" do
      stub_get("https://api.foursquare.com/v2/venues/4b2a544ff964a5204ca724e3/menu?oauth_token=#{@client.oauth_token}", "venues/venue_menus.json")
      response = @client.venue_menus('4b2a544ff964a5204ca724e3')
      response.menu.menus.items.count.should == 1
      response.menu.menus.items.first.name.should == "Main Menu"
      response.menu.menus.items.first['entries']['items'].first['entries'].items.count.should == 11
    end
    
    should "get currently checked in users for a venue" do
      stub_get("https://api.foursquare.com/v2/venues/4a1c8506f964a520457b1fe3/herenow?oauth_token=#{@client.oauth_token}", "venues/venue_herenow.json")
      response = @client.herenow('4a1c8506f964a520457b1fe3')
      response.hereNow.count.should == 2
      response.hereNow.items.first.user.firstName.should == "Sabine"
      response.hereNow.items.count.should == 2
    end

    should "get detailed stats for a venue managed by user" do
      stub_get("https://api.foursquare.com/v2/venues/4b8c3d87f964a520f7c532e3/stats?oauth_token=#{@client.oauth_token}", "venues/venue_stats.json")
      response = @client.managed_venue_stats('4b8c3d87f964a520f7c532e3')
      response.stats.totalCheckins.should == 1
    end

    should "get a subset of detailed stats for a venue managed by user when passing in options" do
      stub_get("https://api.foursquare.com/v2/venues/4b8c3d87f964a520f7c532e3/stats?oauth_token=#{@client.oauth_token}&startAt=1343085269&endAt=1343171627", "venues/venue_stats.json")
      response = @client.managed_venue_stats('4b8c3d87f964a520f7c532e3', { :startAt => 1343085269, :endAt => 1343171627})
      response.stats.totalCheckins.should == 1
    end

    should "get hours from a venue" do
      stub_get("https://api.foursquare.com/v2/venues/49d68c61f964a520e65c1fe3/hours?oauth_token=#{@client.oauth_token}", "venues/venue_hours.json")
      response = @client.venue_hours('49d68c61f964a520e65c1fe3')
      response.hours.timeframes.first.days.should == [1, 2, 3, 4, 5, 6]
    end

    should "get events from a venue" do
      stub_get("https://api.foursquare.com/v2/venues/40afe980f964a5203bf31ee3/events?oauth_token=#{@client.oauth_token}", "venues/venue_events.json")
      response = @client.venue_events('40afe980f964a5203bf31ee3')
      response.events.items.first.name.should == 'Nautanki Saala!'
      response.events.items.size == response.events.count
    end

    should "get likes for a venue" do
      stub_get("https://api.foursquare.com/v2/venues/4b8c3d87f964a520f7c532e3/likes?oauth_token=#{@client.oauth_token}", "venues/venue_likes.json")
      response = @client.venue_likes('4b8c3d87f964a520f7c532e3')
      response.likes.groups.first.items.first.id.should == '53698158'
      response.likes.count == 140
    end

    should "get lists for a venue" do
      stub_get("https://api.foursquare.com/v2/venues/4989af90f964a5207f521fe3/listed?oauth_token=#{@client.oauth_token}&group=other&limit=4&offset=0", "venues/venue_listed.json")
      response = @client.venue_listed('4989af90f964a5207f521fe3', { :group => 'other', :limit => 4, :offset => 0})
      response.lists.items.first.id == '4e5b95beb61c4aaa3e182d8d'
      response.lists.count == 4
    end

    should "get next venues for a venue" do
      stub_get("https://api.foursquare.com/v2/venues/4b8c3d87f964a520f7c532e3/nextvenues?oauth_token=#{@client.oauth_token}", "venues/venue_nextvenues.json")
      response = @client.venue_nextvenues('4b8c3d87f964a520f7c532e3')
      response.nextVenues.items.first.id.should == '4b06a391f964a5200aee22e3'
      response.nextVenues.count == 5
    end

    should "get similar venues for a venue" do
      stub_get("https://api.foursquare.com/v2/venues/40a55d80f964a52020f31ee3/similar?oauth_token=#{@client.oauth_token}", "venues/venue_similar.json")
      response = @client.venue_similar('40a55d80f964a52020f31ee3')
      response.similarVenues.items.first.id.should == '4b61cec9f964a52023242ae3'
      response.similarVenues.count == 5
    end

    context "and getting detailed stats for a venue not managed by user" do
      should "raise a 'not authorized' API error" do
        stub_get("https://api.foursquare.com/v2/venues/4ad4c04af964a52065f220e3/stats?oauth_token=#{@client.oauth_token}", nil,
          :error => { :code => '403', :type => 'not_authorized', :message => 'User is not authorized to view venue stats' })
        assert_raises(Foursquare2::APIError) do
          @client.managed_venue_stats('4ad4c04af964a52065f220e3')
        end
      end
    end

  end

end
