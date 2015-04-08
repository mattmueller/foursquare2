require 'helper'

class TestMulti < Test::Unit::TestCase

  context "When using the foursquare API and working with multiple requests" do
    setup do
      @client = foursquare_test_client
    end

    should "fetch cw for a single venue" do
      stub_post("https://api.foursquare.com/v2/multi?oauth_token=#{@client.oauth_token}", "multi/multi.json")
      requests = [
        "/venues/4b8c3d87f964a520f7c532e3",
        "/venues/4b8c3d87f964a520f7c532e3",
      ]
      responses = @client.multi(requests, v: 20150101)

      responses.first.response.venue.id.should == "4b8c3d87f964a520f7c532e3"
    end

  end

end
