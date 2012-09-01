require 'helper'

class TestCheckins < Test::Unit::TestCase

  context "When using the foursquare API and working with checkins" do
    setup do
      @client = foursquare_test_client
    end

    should "fetch info for a single checkin" do
      stub_get("https://api.foursquare.com/v2/checkins/4d572bcc9e508cfab975189b?oauth_token=#{@client.oauth_token}", "checkins/checkin.json")
      checkin = @client.checkin('4d572bcc9e508cfab975189b')
      checkin.venue.name.should == 'Bridgestone Arena'
      checkin.user.firstName.should == 'Matt'
    end

    should "fetch recent checkins from friends"do
      stub_get("https://api.foursquare.com/v2/checkins/recent?oauth_token=#{@client.oauth_token}&limit=2", "checkins/friend_checkins.json")
      checkins = @client.recent_checkins(:limit => 2)
      checkins.count.should == 2
      checkins.first.venue.name.should == 'Buffalo Billiards'
      checkins.last.user.firstName.should == 'David'
    end

    should "add a post to an existing checkin" do
      stub_post("https://api.foursquare.com/v2/checkins/5041335de4b08d95c1591453/addpost?oauth_token=#{@client.oauth_token}&text=Test", "checkins/post_created.json")
      post = @client.add_checkin_post('5041335de4b08d95c1591453', :text => "Test")
      post.text.should == "Test"
    end

    should "add a reply to an existing checkin" do
      stub_post("https://api.foursquare.com/v2/checkins/5041eda9e4b0133020c2292c/reply?oauth_token=#{@client.oauth_token}&text=Test", "checkins/checkin_reply.json")
      reply = @client.add_checkin_reply('5041eda9e4b0133020c2292c', :text => "Test")
      reply.text.should == "Test"
    end
  end

end
