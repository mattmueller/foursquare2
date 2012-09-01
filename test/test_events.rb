require 'helper'

class TestEvents < Test::Unit::TestCase

  context "When using the foursquare API and working with events" do
    setup do
      @client = foursquare_test_client
    end

    should "fetch list of event categories" do
      stub_get("https://api.foursquare.com/v2/events/categories?oauth_token=#{@client.oauth_token}", "events/event_categories.json")
      event_categories = @client.event_categories()
      event_categories.first.name.should == "Movies"
    end

    should "fetch info for a single event" do
      stub_get("https://api.foursquare.com/v2/events/4f98d496f6903e7ae2a3628c?oauth_token=#{@client.oauth_token}", "events/event.json")
      event = @client.event('4f98d496f6903e7ae2a3628c')
      event.name.should == "Marvel's The Avengers"
    end
  end

end
