require 'helper'

class TestPages < Test::Unit::TestCase

  context "When using the foursquare API and working with pages" do
    setup do
      @client = foursquare_test_client
    end

    should "fetch info for a single page" do
      stub_get("https://api.foursquare.com/v2/pages/14046309?oauth_token=#{@client.oauth_token}", "pages/page.json")
      page = @client.page('14046309')
      page.firstName.should == "Nashville Geeks"
      page.type.should == "page"
    end

    should "fetch results when searching for a page" do
      stub_get("https://api.foursquare.com/v2/pages/search?name=NashvilleGeeks&oauth_token=#{@client.oauth_token}", "pages/search_pages.json")
      pages = @client.search_pages(:name => 'NashvilleGeeks')
      pages.results.first.firstName.should == "Nashville Geeks"
    end

    should "fetch venues for a given page" do
      stub_get("https://api.foursquare.com/v2/pages/1070527/venues?limit=2&oauth_token=#{@client.oauth_token}", "pages/page_venues.json")
      venues = @client.page_venues(1070527, :limit => 2)
      venues['count'].should == 11051
      venues.items.length.should == 2
      venues.items.first.name.should == "Starbucks"
    end
  end
end