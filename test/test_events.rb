require 'helper'

class TestEvents < Test::Unit::TestCase

  context "When using the foursquare API and working with events" do
    setup do
      @client = foursquare_test_client
    end

    should "fetch list of event categories" do
      stub_get("https://api.foursquare.com/v2/events/categories?oauth_token=#{@client.oauth_token}", "event_categories.json")
      event_categories = @client.event_categories()
      event_categories.first.name.should == "Movies"
    end
  end

end
