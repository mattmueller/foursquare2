module Foursquare2
  module Checkins

    def checkin(checkin_id)
      response = connection.get("checkins/#{checkin_id}")
      return_error_or_body(response, response.body.response.checkin)
    end

    def recent_checkins(options={})
      response = connection.get do |req|
        req.url "checkins/recent", options
      end
      return_error_or_body(response, response.body.response.recent)
    end

    def add_checkin(options={})
      response = connection.post do |req|
        req.url "checkins/add", options
      end
      return_error_or_body(response, response.body.response.checkin)
    end

    def add_checkin_comment(checkin_id, options={})
      response = connection.post do |req|
        req.url "checkins/#{checkin_id}/addcomment", options
      end
      return_error_or_body(response, response.body.response)  
    end

    def delete_checkin_comment(checkin_id, options={})
      response = connection.post do |req|
        req.url "checkins/#{checkin_id}/deletecomment", options
      end
      return_error_or_body(response, response.body.response)  
    end

  end    
end

