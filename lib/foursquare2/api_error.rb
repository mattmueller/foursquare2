module Foursquare2
  class APIError < StandardError

    attr_reader :code
    attr_reader :detail
    attr_reader :type
    attr_reader :response

    def initialize(error, response)
      @code   = error.code
      @detail = error.errorDetail
      @type   = error.errorType
      @response = response
    end

    def message
      "#{@type}: #{@detail} (#{@code})"
    end
    alias :to_s :message
  end
end
