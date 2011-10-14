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
    
    should "retain SSL option for requests when you don't pass it as param" do
      @client = Foursquare2::Client.new(:client_id => 'awesome', :client_secret => 'sauce')
      @client.ssl.should == {}
    end
    
    should "retain SSL option for requests" do
      @client = Foursquare2::Client.new(:client_id => 'awesome', :client_secret => 'sauce', :ssl => {:ca_file => 'path_to_ca_file'})      
      @client.ssl[:ca_file].should == 'path_to_ca_file'
    end
  end

  context "When returning a successful response" do
    should "return the response body as a Hash." do
      response = Faraday::Response.new body: fixture_file('search_venues.json', :parse => true)
      client   = Foursquare2::Client.new

      subject = client.return_error_or_body(response, response.body.response)
      subject.should eql(response.body.response)
    end
  end

end
