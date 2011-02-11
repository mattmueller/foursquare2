module Foursquare2
  module Specials

    def special(special_id)
      response = connection.get("specials/#{special_id}")
      return_error_or_body(response, response.body.response.special)
    end    

    def search_specials
      response = connection.get do |req|
        req.url "specials/search", options
      end
      return_error_or_body(response, response.body.response.specials.items)
    end
    
  end
end

