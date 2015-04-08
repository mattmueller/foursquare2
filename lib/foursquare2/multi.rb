module Foursquare2
  module Multi

    # Retrieve multiple requests
    #
    # param [Array] queries the uri encoded request urls

    def multi(requests, options = {})
      escaped_requests = requests.map {|r| CGI.escape(r) }.join(",")

      options.merge!(requests: escaped_requests)

      response = connection.post do |req|
        req.url "multi", options
      end
      return_error_or_body(response, response.body.response.responses)
    end
  end
end
