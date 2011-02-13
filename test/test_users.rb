require 'helper'

class TestUsers < Test::Unit::TestCase

  context "When using the foursquare API and working with users" do
    setup do
      @client = foursquare_test_client
    end

    should "fetch info for a single user" do
      stub_get("https://api.foursquare.com/v2/users/self?oauth_token=#{@client.oauth_token}", "user.json")
      user = @client.user('self')
      user.firstName.should == 'Matt'
      user.checkins['count'].should == 669
    end

    should "fetch results when searching for users" do
      stub_get("https://api.foursquare.com/v2/users/search?oauth_token=#{@client.oauth_token}&twitter=matt_mueller", "search_users.json")
      users = @client.search_users(:twitter => 'matt_mueller')
      users.results.count.should == 1
      users.results.first.lastName.should == 'Mueller'
    end
  end
end
