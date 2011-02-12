module Foursquare2
  module Users

    def user(user_id)
      response = connection.get("users/#{user_id}")
      return_error_or_body(response, response.body.response.user)
    end

    def search_users(options={})
      response = connection.get do |req|
        req.url "users/search", options
      end
      return_error_or_body(response, response.body.response)
    end

    def user_requests
      response = connection.get("users/requests")
      return_error_or_body(response, response.body.response.requests)
    end

    def user_badges(user_id)
      response = connection.get("users/#{user_id}/badges")
      return_error_or_body(response, response.body.response.sets)
    end

    def user_checkins(options={})
      response = connection.get do |req|
        req.url "users/self/checkins", options
      end
      return_error_or_body(response, response.body.response.checkins)
    end

    def user_friends(user_id, options={})
      response = connection.get do |req|
        req.url "users/#{user_id}/friends", options
      end
      return_error_or_body(response, response.body.response.friends)
    end

    def user_tips(user_id, options={})
      response = connection.get do |req|
        req.url "users/#{user_id}/tips", options
      end
      return_error_or_body(response, response.body.response.tips)
    end

    def user_tips(user_id, options={})
      response = connection.get do |req|
        req.url "users/#{user_id}/todos", options
      end
      return_error_or_body(response, response.body.response.todos)
    end

    def user_venue_history(options={})
      response = connection.get do |req|
        req.url "users/self/venuehistory", options
      end
      return_error_or_body(response, response.body.response.venues)
    end

    def user_friend_request(user_id)
      response = connection.post do |req|
        req.url "users/#{user_id}/request"
      end
      return_error_or_body(response, response.body.response)
    end   

    def user_unfriend(user_id)
      response = connection.post do |req|
        req.url "users/#{user_id}/unfriend"
      end
      return_error_or_body(response, response.body.response)
    end 

    def user_approve_friend(user_id)
      response = connection.post do |req|
        req.url "users/#{user_id}/approve"
      end
      return_error_or_body(response, response.body.response)
    end 

    def user_deny_friend(user_id)
      response = connection.post do |req|
        req.url "users/#{user_id}/deny"
      end
      return_error_or_body(response, response.body.response)
    end 

    def user_set_friend_pings(user_id, value)
      response = connection.post do |req|
        req.url "users/#{user_id}/setpings", value
      end
      return_error_or_body(response, response.body.response)
    end 

  end
end
