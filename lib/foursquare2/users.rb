module Foursquare2
  module Users

    # Get user's leaderboard details
    #
    # @param [Hash] options
    # @option options Integer :neighbors Number of friends' scores adjacent to your score
    
    def leaderboard(options={})
      response = connection.get do |req|
        req.url "users/leaderboard", options
      end
      return_error_or_body(response, response.body.response)
    end

    # Get information about a user
    #
    # @param [Integer] user_id - User to get information for.

    def user(user_id)
      response = connection.get("users/#{user_id}")
      return_error_or_body(response, response.body.response.user)
    end

    # Search for users
    # @param [Hash]  options
    # @option options String :phone - Match on phone number
    # @option options String :email - Match on email
    # @option options String :twitter - Match on twitter username
    # @option options String :twitterSource - Friends of this twitter handle that use foursquare.
    # @option options String :fbid - Match on facebook id.
    # @option options String :name - Match on name

    def search_users(options={})
      response = connection.get do |req|
        req.url "users/search", options
      end
      return_error_or_body(response, response.body.response)
    end

    # Search for users by tip
    # @param [Hash]  options
    # @option options String :ll - Latitude and longitude in format LAT,LON
    # @option options Integer :limit - The limit of results to return.
    # @option options Integer :offset - Used to page through results.
    # @option options String :filter - Set to 'friends' to limit tips to those from friends.
    # @option options String :query - Only find tips matching this term.
    # @option options String :name - Match on name

    def search_users_by_tip(options={})
      name = options.delete(:name)
      options[:limit] = 500
      tips = search_tips(options)
      user = []
      tips.each do |tip|
        user << tip['user'] if check_name(tip['user'], name)
      end
      user.uniq
  end

    # check if the first last name of user match the query

    def check_name user, query
      user.firstName.downcase.match(query.downcase)
    end
    # Get all pending friend requests for the authenticated user

    def user_requests
      response = connection.get("users/requests")
      return_error_or_body(response, response.body.response.requests)
    end

    # Get all badges for a given user.
    #
    # @param [String] user_id - The user to retrieve badges for.

    def user_badges(user_id)
      response = connection.get("users/#{user_id}/badges")
      return_error_or_body(response, response.body.response)
    end

    # Get checkins for the authenticated user
    # @param [Hash]  options
    # @option options Integer :limit
    # @option options Integer :offest - For paging through results
    # @option options String  :sort - "newestfirst" or "oldestfirst"
    # @option options Integer :afterTimestamp - Get all checkins after this epoch time.
    # @option options Integer :beforeTimestamp - Get all checkins before this epoch time.

    def user_checkins(options={})
      response = connection.get do |req|
        req.url "users/self/checkins", options
      end
      return_error_or_body(response, response.body.response.checkins)
    end

    # Get all friends for a given user.
    #
    # @param [String] user_id - The user to retrieve friends for.
    # @param [Hash]  options
    # @option options Integer :limit
    # @option options Integer :offest - For paging through results

    def user_friends(user_id, options={})
      response = connection.get do |req|
        req.url "users/#{user_id}/friends", options
      end
      return_error_or_body(response, response.body.response.friends)
    end

    # Get all tips for a given user, optionally filtering by text.
    #
    # @param [String] user_id - The user to retrieve friends for.
    # @param [Hash]  options
    # @option options Integer :limit
    # @option options Integer :offest - For paging through results
    # @option options String :sort - One of recent, nearby, popular
    # @option options String :ll - Latitude and longitude in format LAT,LON - required for nearby sort option.
    # @option String :query - Only find tips matching this term.

    def user_tips(user_id, options={})
      response = connection.get do |req|
        req.url "users/#{user_id}/tips", options
      end
      tips = return_error_or_body(response, response.body.response.tips)
      tips = Foursquare2.filter(tips, options[:query]) if options.has_key? :query
      tips
    end

    # Get all todos for a given user.
    #
    # @param [String] user_id - The user to retrieve friends for.
    # @param [Hash]  options
    # @option options String :sort - One of recent, nearby, popular
    # @option options String :ll - Latitude and longitude in format LAT,LON - required for nearby sort option.


    def user_todos(user_id, options={})
      response = connection.get do |req|
        req.url "users/#{user_id}/todos", options
      end
      return_error_or_body(response, response.body.response.todos)
    end

    # Get the venue history for the authenticated user.
    #
    # @param [Hash]  options
    # @option options Integer :afterTimestamp - Get all venues after this epoch time.
    # @option options Integer :beforeTimestamp - Get all venues before this epoch time.


    def user_venue_history(options={})
      response = connection.get do |req|
        req.url "users/self/venuehistory", options
      end
      return_error_or_body(response, response.body.response.venues)
    end

    # Get the mayorships for a given user.
    #
    # @param [String] user_id - The user to retrieve friends for.

    def user_mayorships(user_id)
      response = connection.get do |req|
      req.url "users/#{user_id}/mayorships"
      end
      return_error_or_body(response, response.body.response.mayorships)
    end

    # Get the lists for a given user.
    #
    # @param [String] user_id - The user to retrieve lists for.
    # @param [Hash] options
    # @option options String :group - One of: created, edited, followed, friends, or suggestions
    # @option options String :ll - Location of the user, required in order to receive the suggested group.

    def user_lists(user_id, options={})
      response = connection.get do |req|
        req.url "users/#{user_id}/lists", options
      end
      return_error_or_body(response, response.body.response.lists)
    end

    # Request friendship with a user
    #
    # @param [String] user_id - The user to request friendship with.

    def user_friend_request(user_id)
      response = connection.post do |req|
        req.url "users/#{user_id}/request"
      end
      return_error_or_body(response, response.body.response)
    end

    # Unfriend a user
    #
    # @param [String] user_id - The user to unfriend.

    def user_unfriend(user_id)
      response = connection.post do |req|
        req.url "users/#{user_id}/unfriend"
      end
      return_error_or_body(response, response.body.response)
    end

    # Approve friendship with a user.
    #
    # @param [String] user_id - The user to approve friendship with.

    def user_approve_friend(user_id)
      response = connection.post do |req|
        req.url "users/#{user_id}/approve"
      end
      return_error_or_body(response, response.body.response)
    end

    # Deny friendship with a user.
    #
    # @param [String] user_id - The user to deny friendship with.

    def user_deny_friend(user_id)
      response = connection.post do |req|
        req.url "users/#{user_id}/deny"
      end
      return_error_or_body(response, response.body.response)
    end

    # Set pings for a friend
    #
    # @param [String] user_id - The user to set pings for
    # @param [String] value - The value of ping setting for this friend, either true or false.

    def user_set_friend_pings(user_id, value)
      response = connection.post do |req|
        req.url "users/#{user_id}/setpings", value
      end
      return_error_or_body(response, response.body.response)
    end

    # Summary of venues visited by a user
    # optional @param [String] user_id - The user to get venue stats for.
    #
    # @option options Integer :afterTimestamp - checkins after this epoch time.
    # @option options Integer :beforeTimestamp - checkins before this epoch time.
    def venuestats(user_id="self", options={})
      response = connection.get do |req|
        req.url "users/#{user_id}/venuestats", options
      end
      return_error_or_body(response, response.body.response)
    end

  end
end
