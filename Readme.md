# foursquare2

Ruby wrapper for the [foursquare v2 API](http://developer.foursquare.com/docs).

## Installation

    sudo gem install foursquare2

## Usage

### A Note on Authentication

Currently this gem does not handle the oauth2 authentication flow for you, use the [oauth2 gem](https://github.com/intridea/oauth2) to retrieve and store oauth tokens for a user.  Obtain your client key/secret for userless access at the [foursquare developer site.](https://foursquare.com/oauth/)

### Instantiate a client (Userless Access)

    client = Foursquare2::Client.new(:client_key => 'your_key', :client_secret => 'your_secret')

### Instantiate a client (Authenticated User Access)

    client = Foursquare2::Client.new(:oauth_token => 'user_oauth_token')


### Examples

See [the documentation](http://rubydoc.info/gems/foursquare2) for a list of all supported methods and available options.

#### Get information about a user (use 'self' for the authenticated user)

    client.user(108914) 

#### Get information about a venue

    client.venue(5104)

#### Search for venues

    client.search_venues(:ll => '36.142064,-86.816086', :query => 'Starbucks')

#### Check-in to a venue as the authenticated user

    client.checkin(:venueId => "4b2afcaaf964a5205bb324e3", :broadcast => 'public', :ll => '36.142064,-86.816086', :shout => 'zomg coffee!1!')

## Todo

* Add test coverage
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
