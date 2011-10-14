module Foursquare2
  class Error < StandardError

    attr_reader :code
    attr_reader :detail
    attr_reader :type

    def initialize(error)
      @code   = error.code
      @detail = error.errorDetail
      @type   = error.errorType
    end

    def message
      "#{@type}: #{@detail} (#{@code})"
    end

  end
end
