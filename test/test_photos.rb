require 'helper'

class TestPhotos < Test::Unit::TestCase

  context "When using the foursquare API and working with photos" do
    setup do
      @client = foursquare_test_client
    end

    should "fetch info for a single photo" do
      stub_get("https://api.foursquare.com/v2/photos/4d0fb8162d39a340637dc42b?oauth_token=#{@client.oauth_token}", "photos/photo.json")
      photo = @client.photo('4d0fb8162d39a340637dc42b')
      photo.sizes.items.count.should == 4
      photo.sizes.items.first.url.should == "http://playfoursquare.s3.amazonaws.com/pix/UYU54GYOCURPAUYXH5V2U3EOM4DCX4VZPT3YOMN43H555KU2.jpg"
    end
  end
end
