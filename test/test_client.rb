require 'helper'

class TestClient < Test::Unit::TestCase
  
 context "when instantiating a client instance" do
    should "use the correct url for api requests" do
      @client = Foursquare2::Client.new
      @client.api_url.should == 'https://api.foursquare.com/v2'
    end

    should "retain oauth token for requests" do
      @client = Foursquare2::Client.new(:oauth_token => 'yeehaw')
      @client.oauth_token.should == "yeehaw"
    end

    should "retain client id/secret for requests" do
      @client = Foursquare2::Client.new(:client_id => 'awesome', :client_secret => 'sauce')
      @client.client_id.should == 'awesome'
      @client.client_secret.should == 'sauce'
    end
  end
end
