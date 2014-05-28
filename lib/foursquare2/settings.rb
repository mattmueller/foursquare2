module Foursquare2
  module Settings

    # Retrive all settings for the authenticated user.

    def settings(options={})
      response = connection.get do |req|
        req.url "settings/all", options
      end
      return_error_or_body(response, response.body.response.settings)
    end

    # Retrieve a single setting for the authenticated user.
    #
    # @param [String] setting - The name of the setting to retrieve, one of sendtotwitter, sendtofacebook, pings.

    def setting(setting, options={})
      response = connection.get do |req|
        req.url "settings/setting", options
      end
      return_error_or_body(response, response.body.response)
    end

    # Update a single setting for the authenticated user.
    #
    # @param [String] setting - The name of the setting to update, one of sendtotwitter, sendtofacebook, pings.
    # @param [String] value - One of '1','0'

    def update_setting(setting, value, options={})
      response = connection.post do |req|
        req.url "settings/#{setting}/set", {:value => value}.merge(options)
      end
      return_error_or_body(response, response.body.response)
    end

  end
end

