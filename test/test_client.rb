require 'helper'

class TestClient < Test::Unit::TestCase

  context "when configuring the client at a class level" do
    should "use the class-assigned attributes for new instances" do
      Foursquare2.configure do |config|
        config.client_id = 'awesome'
        config.client_secret = 'sauce'
        config.api_version = 5551234
        config.ssl = true
      end
      client = Foursquare2::Client.new
      client.client_id.should == 'awesome'
      client.client_secret.should == 'sauce'
      client.api_version.should == 5551234
      client.ssl.should == true
    end

    should 'use the class-assigned middleware if provided' do
      Foursquare2.configure do |config|
        config.connection_middleware = [:middleware]
      end
      Faraday::Builder.any_instance.expects(:use).at_least_once
      Faraday::Builder.any_instance.expects(:use) \
        .with(:middleware)
      client = Foursquare2::Client.new
      client.connection
    end

    teardown do
      Foursquare2.configure do |config|
        config.client_id = nil
        config.client_secret = nil
        config.api_version = nil
        config.connection_middleware = nil
        config.ssl = nil
      end
    end
  end

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

    should "retain api version for requests" do
      @client = Foursquare2::Client.new(:api_version => '20120505')
      @client.api_version.should == "20120505"
    end

    should "retain api locale for requests" do
      @client = Foursquare2::Client.new(:locale => 'es')
      @client.locale.should == "es"
    end

    should "retain SSL option for requests when you don't pass it as param" do
      @client = Foursquare2::Client.new(:client_id => 'awesome', :client_secret => 'sauce')
      @client.ssl.should == {}
    end

    should "retain SSL option for requests" do
      @client = Foursquare2::Client.new(:client_id => 'awesome', :client_secret => 'sauce', :ssl => {:ca_file => 'path_to_ca_file'})
      @client.ssl[:ca_file].should == 'path_to_ca_file'
    end

    should "apply the middleware to the connection" do
      middleware = [FaradayMiddleware::Instrumentation,
                    [FaradayMiddleware::ParseJson, {:content_type => /\bjson$/}]]
      client = Foursquare2::Client.new(:connection_middleware => middleware)

      Faraday::Builder.any_instance.expects(:use).at_least_once
      Faraday::Builder.any_instance.expects(:use) \
        .with(FaradayMiddleware::Instrumentation)
      Faraday::Builder.any_instance.expects(:use) \
        .with(FaradayMiddleware::ParseJson, {:content_type => /\bjson$/})

      client.connection
    end
  end

  context "When returning a successful response" do
    should "return the response body as a Hash." do
      response = Faraday::Response.new(:body => fixture_file('venues/search_venues.json', :parse => true))
      client   = Foursquare2::Client.new

      subject = client.return_error_or_body(response, response.body.response)
      subject.should eql(response.body.response)
    end
  end

  context "When returning a unsucessful response(error)" do
    should "raise Foursquare2::Error." do
      response = Faraday::Response.new(:body => fixture_file('error.json', :parse => true))
      client   = Foursquare2::Client.new

      assert_raises(Foursquare2::APIError) do
        client.return_error_or_body(response, response.body)
      end
    end
  end

end
