module Foursquare2
  module Tips

    def tip(tip_id)
      response = connection.get("tips/#{tip_id}")
      return_error_or_body(response, response.body.response.tip)
    end    

    def search_tips(options={})
      response = connection.get do |req|
        req.url "tips/search", options
      end
      return_error_or_body(response, response.body.response.tips)
    end

    def add_tip(options={})
      response = connection.post do |req|
        req.url "tips/add", options
      end
      return_error_or_body(response, response.body.response.tip)
    end

    def mark_tip_todo(tip_id)
      response = connection.post do |req|
        req.url "tips/#{tip_id}/marktodo"
      end
      return_error_or_body(response, response.body.response)
    end

    def mark_tip_done(tip_id)
      response = connection.post do |req|
        req.url "tips/#{tip_id}/markdone"
      end
      return_error_or_body(response, response.body.response)
    end

    def unmark_tip(tip_id)
      response = connection.post do |req|
        req.url "tips/#{tip_id}/unmark"
      end
      return_error_or_body(response, response.body.response)
    end

  end
end
