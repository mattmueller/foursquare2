require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'test/unit'
require 'shoulda'
require 'matchy'
require 'fakeweb'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'foursquare2'

FakeWeb.allow_net_connect = false

def foursquare_test_client
  Foursquare2::Client.new(:oauth_token => 'yeehaw')
end

def foursquare_url(url)
  url = "https://api.foursquare.com/v2#{url}"
end

class Test::Unit::TestCase
end
