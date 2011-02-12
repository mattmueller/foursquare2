module Foursquare2
  module Settings

    # Retrive all settings for the authenticated user.

    def settings
      response = connection.get("settings/all")
      return_error_or_body(response, response.body.response.settings)
    end    

    # Retrieve a single setting for the authenticated user.
    #
    # @param [String] setting - The name of the setting to retrieve, one of sendtotwitter, sendtofacebook, pings.

    def setting(setting)
      response = connection.get("settings/setting")
      return_error_or_body(response, response.body.response)
    end

    # Update a single setting for the authenticated user.
    #
    # @param [String] setting - The name of the setting to update, one of sendtotwitter, sendtofacebook, pings.
    # @param [String] value - One of '1','0'

    def update_setting(setting,value)
      response = connection.post do |req|
        req.url "settings/#{setting}/set", {:value => value}
      end
      return_error_or_body(response, response.body.response)
    end
    
  end
end

