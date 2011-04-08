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

    should "fetch tips" do
      stub_get("https://api.foursquare.com/v2/users/self/tips?oauth_token=#{@client.oauth_token}", "user_tips.json")
      tips = @client.user_tips('self')
      tips.items.first.text.should == "Encontrei mesas e chao sujos."
      tips.items.size.should == 12 
    end

    should "fetch tips and filter with some term" do
      stub_get("https://api.foursquare.com/v2/users/self/tips?oauth_token=#{@client.oauth_token}&query=bar", "user_tips.json")
      tips = @client.user_tips_by_text('self', {:query => 'bar'})
      tips.items.size.should == 0 
    end

    should "no fetch tips and filter with some term" do
      stub_get("https://api.foursquare.com/v2/users/self/tips?oauth_token=#{@client.oauth_token}&query=LorenIpsun", "user_tips_empty.json")
      tips = @client.user_tips_by_text('self', {:query => 'LorenIpsun'})
      tips.items.size.should == 0 
    end

  end
end
