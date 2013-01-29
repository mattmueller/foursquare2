require 'helper'

class TestUsers < Test::Unit::TestCase

  context "When using the foursquare API and working with users" do
    setup do
      @client = foursquare_test_client
    end

    should "fetch user's leaderboard" do
      stub_get("https://api.foursquare.com/v2/users/leaderboard?oauth_token=#{@client.oauth_token}&neighbors=2", "users/leaderboard.json", )
      leaderboard = @client.leaderboard(:neighbors => 2)
      leaderboard.leaderboard['count'].should == 3
    end

    should "fetch info for a single user" do
      stub_get("https://api.foursquare.com/v2/users/self?oauth_token=#{@client.oauth_token}", "users/user.json")
      user = @client.user('self')
      user.firstName.should == 'Matt'
      user.checkins['count'].should == 669
    end

    should "fetch results when searching for users" do
      stub_get("https://api.foursquare.com/v2/users/search?oauth_token=#{@client.oauth_token}&twitter=matt_mueller", "users/search_users.json")
      users = @client.search_users(:twitter => 'matt_mueller')
      users.results.count.should == 1
      users.results.first.lastName.should == 'Mueller'
    end

    should "fetch tips" do
      stub_get("https://api.foursquare.com/v2/users/self/tips?oauth_token=#{@client.oauth_token}", "users/user_tips.json")
      tips = @client.user_tips('self')
      tips.items.first.text.should == "Encontrei mesas e chao sujos."
      tips.items.size.should == 12
    end

    should "fetch tips and filter with term #{QUERY}" do
      stub_get("https://api.foursquare.com/v2/users/self/tips?oauth_token=#{@client.oauth_token}&query=#{QUERY}", "users/user_tips.json")
      tips = @client.user_tips('self', {:query => QUERY})
      tips.items.size.should == 1
    end

    should "fetch lists for a single user" do
      stub_get("https://api.foursquare.com/v2/users/self/lists?oauth_token=#{@client.oauth_token}", "users/user_lists.json")
      lists = @client.user_lists('self')
      lists.items.size.should == 21
    end

    #TODO refactoring all call to method stub_get

    should "list only user with tip #{QUERY}" do
      stub_get("https://api.foursquare.com/v2/tips/search?oauth_token=#{@client.oauth_token}&ll=77.7%2C-77.7&query=#{QUERY}&limit=500", "tips/search_tips.json")
      users = @client.search_users_by_tip({:name => 'developer', :ll =>'77.7,-77.7', :query => QUERY})
      users.first.id.should == "2227298"
      users.size.should == 1
    end

    should "find by name not case sensitive" do
      stub_get("https://api.foursquare.com/v2/tips/search?oauth_token=#{@client.oauth_token}&ll=77.7%2C-77.7&query=#{QUERY}&limit=500", "tips/search_tips.json")
      users = @client.search_users_by_tip({:name => 'Developer', :ll =>'77.7,-77.7', :query => QUERY})
      users.first.id.should == "2227298"
      users.size.should == 1
    end

    should "haven't user with name anonymous with tip #{QUERY}" do
      stub_get("https://api.foursquare.com/v2/tips/search?oauth_token=#{@client.oauth_token}&ll=77.7%2C-77.7&query=#{QUERY}&limit=500", "tips/search_tips.json")
      users = @client.search_users_by_tip({:name => 'anonymous', :ll =>'77.7,-77.7', :query => QUERY})
      users.size.should == 0
    end

    should "find a users mayorships" do
      stub_get("https://api.foursquare.com/v2/users/self/mayorships?oauth_token=#{@client.oauth_token}", "users/user_mayorships.json")
      mayorships = @client.user_mayorships('self')
      mayorships.items.size.should == 2
    end

    should "find a users checkins - plain (without optional params)" do
      stub_get("https://api.foursquare.com/v2/users/self/checkins?oauth_token=#{@client.oauth_token}", "users/user_checkins_plain.json")
      checkins = @client.user_checkins
      checkins.items.size.should == 20
    end

    should "find a users checkins with afterTimestamp param" do
      stub_get("https://api.foursquare.com/v2/users/self/checkins?oauth_token=#{@client.oauth_token}&limit=10&offset=2&sort=newestfirst&afterTimestamp=1279044824", "users/user_checkins_aftertimestamp.json")
      checkins_after = @client.user_checkins({:limit => 10, :offset => 2, :sort => 'newestfirst', :afterTimestamp => 1279044824})
      checkins_after.items.size.should == 10
      checkins_after.items.reject { |ci| ci.createdAt > 1279044824 }.empty?.should == true
      checkins_after.items.first.createdAt.should > checkins_after.items.last.createdAt
    end

    should "find a users checkins with beforeTimestamp param" do
      stub_get("https://api.foursquare.com/v2/users/self/checkins?oauth_token=#{@client.oauth_token}&limit=5&offset=20&sort=oldestfirst&beforeTimestamp=1355867689", "users/user_checkins_beforetimestamp.json")
      checkins_before = @client.user_checkins({:limit => 5, :offset => 20, :sort => 'oldestfirst', :beforeTimestamp => 1355867689})
      checkins_before.items.size.should == 5
      checkins_before.items.reject { |ci| ci.createdAt < 1355867689 }.empty?.should == true
      checkins_before.items.first.createdAt.should < checkins_before.items.last.createdAt
    end

    should "find a users venuestats by self" do
      stub_get("https://api.foursquare.com/v2/users/self/venuestats?oauth_token=#{@client.oauth_token}", "users/user_venuestats.json")
      venuestats = @client.venuestats
      venuestats.venues.size.should == 5
      venuestats.categories.size.should == 10
    end

    should "find a users venuestats by inputting friends user_id" do
      stub_get("https://api.foursquare.com/v2/users/555555/venuestats?oauth_token=#{@client.oauth_token}", "users/user_venuestats_friend_id.json")
      friends_venuestats = @client.venuestats(555555)
      friends_venuestats.venues.size.should == 5
      friends_venuestats.categories.size.should == 8
    end
  end

end
