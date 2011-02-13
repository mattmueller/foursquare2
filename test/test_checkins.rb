require 'helper'

class TestCheckins < Test::Unit::TestCase

  context "When using the foursquare API and working with checkins" do
    setup do
      @client = foursquare_test_client
    end

    should "fetch info for a single checkin" do
      stub_get("https://api.foursquare.com/v2/checkins/4d572bcc9e508cfab975189b?oauth_token=#{@client.oauth_token}", "checkin.json")
      checkin = @client.checkin('4d572bcc9e508cfab975189b')
      checkin.venue.name.should == 'Bridgestone Arena'
      checkin.user.firstName.should == 'Matt'
    end

    should "fetch recent checkins from friends"do
      stub_get("https://api.foursquare.com/v2/checkins/recent?oauth_token=#{@client.oauth_token}&limit=2", "friend_checkins.json")
      checkins = @client.recent_checkins(:limit => 2)
      checkins.count.should == 2
      checkins.first.venue.name.should == 'Buffalo Billiards'
      checkins.last.user.firstName.should == 'David'
    end
  end

end
