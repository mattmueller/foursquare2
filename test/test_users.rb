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

    should "fetch tips and filter with term #{QUERY}" do
      stub_get("https://api.foursquare.com/v2/users/self/tips?oauth_token=#{@client.oauth_token}&query=#{QUERY}", "user_tips.json")
      tips = @client.user_tips('self', {:query => QUERY})
      tips.items.size.should == 1 
    end

    #TODO refactoring all call to method stub_get

    should "list only user with tip #{QUERY}" do
      stub_get("https://api.foursquare.com/v2/tips/search?oauth_token=#{@client.oauth_token}&ll=77.7%2C-77.7&query=#{QUERY}&limit=500", "search_tips.json")
      users = @client.search_users_by_tip({:name => 'developer', :ll =>'77.7,-77.7', :query => QUERY})
      users.first.id.should == "2227298"
      users.size.should == 1
    end

    should "find by name not case sensitive" do
      stub_get("https://api.foursquare.com/v2/tips/search?oauth_token=#{@client.oauth_token}&ll=77.7%2C-77.7&query=#{QUERY}&limit=500", "search_tips.json")
      users = @client.search_users_by_tip({:name => 'Developer', :ll =>'77.7,-77.7', :query => QUERY})
      users.first.id.should == "2227298"
      users.size.should == 1
    end

    should "haven't user with name anonymous with tip #{QUERY}" do
      stub_get("https://api.foursquare.com/v2/tips/search?oauth_token=#{@client.oauth_token}&ll=77.7%2C-77.7&query=#{QUERY}&limit=500", "search_tips.json")
      users = @client.search_users_by_tip({:name => 'anonymous', :ll =>'77.7,-77.7', :query => QUERY})
      users.size.should == 0
    end

  end
end
