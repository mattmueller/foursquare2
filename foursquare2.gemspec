# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "foursquare2"
  s.version = "1.3.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Matt Mueller", "Marco Moura"]
  s.date = "2012-05-03"
  s.description = "Gives access to all endpoints in version 2 of foursquare's API with syntax that will be familiar to those who used the original foursquare gem by Jeremy Welch."
  s.email = ["muellermr@gmail.com", "email@marcomoura.com"]
  s.extra_rdoc_files = [
    "LICENSE.txt"
  ]
  s.files = [
    ".document",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "Rakefile",
    "Readme.md",
    "VERSION",
    "foursquare2.gemspec",
    "lib/foursquare2.rb",
    "lib/foursquare2/api_error.rb",
    "lib/foursquare2/checkins.rb",
    "lib/foursquare2/client.rb",
    "lib/foursquare2/photos.rb",
    "lib/foursquare2/settings.rb",
    "lib/foursquare2/specials.rb",
    "lib/foursquare2/tips.rb",
    "lib/foursquare2/users.rb",
    "lib/foursquare2/venues.rb",
    "test/config.rb",
    "test/fixtures/checkin.json",
    "test/fixtures/error.json",
    "test/fixtures/explore_venues.json",
    "test/fixtures/friend_checkins.json",
    "test/fixtures/no_venues_by_tip.json",
    "test/fixtures/photo.json",
    "test/fixtures/search_specials.json",
    "test/fixtures/search_tips.json",
    "test/fixtures/search_users.json",
    "test/fixtures/search_venues.json",
    "test/fixtures/search_venues_by_tip.json",
    "test/fixtures/special.json",
    "test/fixtures/suggest_completion_venues.json",
    "test/fixtures/tip.json",
    "test/fixtures/user.json",
    "test/fixtures/user_mayorships.json",
    "test/fixtures/user_tips.json",
    "test/fixtures/user_tips_empty.json",
    "test/fixtures/venue.json",
    "test/fixtures/venue_links.json",
    "test/fixtures/venue_photos.json",
    "test/fixtures/venue_tips.json",
    "test/helper.rb",
    "test/test_checkins.rb",
    "test/test_client.rb",
    "test/test_photos.rb",
    "test/test_specials.rb",
    "test/test_tips.rb",
    "test/test_users.rb",
    "test/test_venues.rb"
  ]
  s.homepage = "http://github.com/mattmueller/foursquare2"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.15"
  s.summary = "Foursquare API v2 gem in the spirit of the original foursquare gem"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<faraday>, ["~> 0.8"])
      s.add_runtime_dependency(%q<faraday_middleware>, [">= 0.8"])
      s.add_runtime_dependency(%q<hashie>, ["~> 1.0"])
      s.add_development_dependency(%q<awesome_print>, [">= 0"])
      s.add_development_dependency(%q<shoulda>, [">= 0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.5"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
      s.add_development_dependency(%q<fakeweb>, ["~> 1.3"])
      s.add_development_dependency(%q<jnunemaker-matchy>, ["~> 0.4"])
      s.add_development_dependency(%q<json_pure>, ["~> 1.4"])
      s.add_development_dependency(%q<multi_json>, ["< 2.0.0", ">= 0.0.5"])
    else
      s.add_dependency(%q<faraday>, ["~> 0.8"])
      s.add_dependency(%q<faraday_middleware>, [">= 0.8"])
      s.add_dependency(%q<hashie>, ["~> 1.0"])
      s.add_dependency(%q<awesome_print>, [">= 0"])
      s.add_dependency(%q<shoulda>, [">= 0"])
      s.add_dependency(%q<bundler>, ["~> 1.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.5"])
      s.add_dependency(%q<rcov>, [">= 0"])
      s.add_dependency(%q<fakeweb>, ["~> 1.3"])
      s.add_dependency(%q<jnunemaker-matchy>, ["~> 0.4"])
      s.add_dependency(%q<json_pure>, ["~> 1.4"])
      s.add_dependency(%q<multi_json>, ["< 2.0.0", ">= 0.0.5"])
    end
  else
    s.add_dependency(%q<faraday>, ["~> 0.8"])
    s.add_dependency(%q<faraday_middleware>, [">= 0.8"])
    s.add_dependency(%q<hashie>, ["~> 1.0"])
    s.add_dependency(%q<awesome_print>, [">= 0"])
    s.add_dependency(%q<shoulda>, [">= 0"])
    s.add_dependency(%q<bundler>, ["~> 1.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.5"])
    s.add_dependency(%q<rcov>, [">= 0"])
    s.add_dependency(%q<fakeweb>, ["~> 1.3"])
    s.add_dependency(%q<jnunemaker-matchy>, ["~> 0.4"])
    s.add_dependency(%q<json_pure>, ["~> 1.4"])
    s.add_dependency(%q<multi_json>, ["< 2.0.0", ">= 0.0.5"])
  end
end

