# foursquare2

Ruby wrapper for the [foursquare v2 API](http://developer.foursquare.com/docs/).

## Installation

    sudo gem install foursquare2

## Usage

### A Note on Authentication

Currently this gem does not handle the oauth2 authentication flow for you, use the [oauth2 gem](https://github.com/intridea/oauth2) to retrieve and store oauth tokens for a user.  Obtain your client key/secret for userless access at the [foursquare developer site.](https://foursquare.com/oauth/)

### Instantiate a client (Userless Access)

    client = Foursquare2::Client.new(:client_id => 'your_client_id', :client_secret => 'your_secret')

### Instantiate a client (Authenticated User Access)

    client = Foursquare2::Client.new(:oauth_token => 'user_oauth_token')

### Instantiate a client (With versioning)

    client = Foursquare2::Client.new(:api_version => '20120505')

### Examples

See [the documentation](http://rubydoc.info/gems/foursquare2/frames) for a list of all supported methods and available options.

#### Get information about a user (use 'self' for the authenticated user)

    client.user(108914)

#### Get information about a venue

    client.venue(5104)

#### Search for venues

    client.search_venues(:ll => '36.142064,-86.816086', :query => 'Starbucks')

#### Check-in to a venue as the authenticated user

    client.add_checkin(:venueId => "4b2afcaaf964a5205bb324e3", :broadcast => 'public', :ll => '36.142064,-86.816086', :shout => 'zomg coffee!1!')


#### Search user by tip

     client.search_users_by_tip(:ll => '36.142064,-86.816086', :name => 'Marco')

#### Search tips from a user (optionally filter a user's tips based on some term)

     client.user_tips("123456", :query => 'coffee')

#### Search venues by tip

     client.search_venues_by_tip(:ll => '36.142064,-86.816086', :query => 'coffee')

#### Search tips at a venue (optionally filter a venue's tips based on some term)

     client.venue_tips("4b2afcaaf964a5205bb324e3", :query => 'coffee')




## Full list of methods

See [the documentation](http://rubydoc.info/gems/foursquare2/frames) or [foursquare's endpoint list](http://developer.foursquare.com/docs/index_docs.html) for parameters.

    client.checkin
    client.recent_checkins
    client.add_checkin
    client.add_checkin_comment
    client.add_checkin_post
    client.add_checkin_reply
    client.delete_checkin_comment
    client.photo
    client.add_photo
    client.settings
    client.setting
    client.update_setting
    client.special
    client.search_specials
    client.tip
    client.search_tips
    client.add_tip
    client.mark_tip_todo
    client.mark_tip_done
    client.unmark_tip
    client.user
    client.search_users
    client.user_requests
    client.user_badges
    client.user_checkins
    client.user_friends
    client.user_tips
    client.user_mayorships
    client.user_todos
    client.user_venue_history
    client.user_friend_request
    client.user_unfriend
    client.user_approve_friend
    client.user_deny_friend
    client.user_set_friend_pings
    client.venue
    client.venue_tips
    client.venue_links
    client.venue_photos
    client.page
    client.search_pages
    client.herenow
    client.page_venues
    client.search_venues
    client.search_venues_by_tip
    client.venue_categories
    client.trending_venues
    client.add_venue
    client.mark_venue_todo
    client.flag_venue
    client.propose_venue_edit
	client.managed_venues
    client.managed_venue_stats
    client.venues_timeseries
	client.add_special
	client.add_campaign

## Todo

* More test coverage
* Integrate oauth2 authentication flow

## Contributing to foursquare2

* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2011 Matt Mueller. See LICENSE.txt for further details.
