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
require 'json'
require 'hashie'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'foursquare2'
require 'config'

FakeWeb.allow_net_connect = false

def foursquare_test_client
  Foursquare2::Client.new(:oauth_token => 'yeehaw')
end

def foursquare_url(url)
  url =~ /^http/ ? url : "http://api.foursquare.com/v2#{url}"
end

def fixture_file(filename, options={})
  return '' if filename == ''
  file_path = File.expand_path(File.dirname(__FILE__) + '/fixtures/' + filename)
  fixture   = File.read(file_path)
  
  case File.extname(file_path)
  when '.json'
    options[:parse] ? Hashie::Mash.new(JSON.parse(fixture)) : fixture
  else
    fixture
  end
end

def stub_get(url, filename, options={})
  opts = {
    :body => fixture_file(filename),
    :content_type => 'application/json; charset=utf-8'
  }.merge(options)
  FakeWeb.register_uri(:get, foursquare_url(url), opts)
end

def stub_post(url, filename, options={})
  opts = {
    :body => fixture_file(filename),
    :content_type => 'application/json; charset=utf-8'
  }.merge(options)
  FakeWeb.register_uri(:post, foursquare_url(url), opts)
end

class Test::Unit::TestCase
end
