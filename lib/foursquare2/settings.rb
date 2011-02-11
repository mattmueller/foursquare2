module Foursquare2
  module Settings

    def settings
      response = connection.get("settings/all")
      return_error_or_body(response, response.body.response.settings)
    end    

    def setting(setting)
      response = connection.get("settings/setting")
      return_error_or_body(response, response.body.response)
    end

    def update_setting(setting,value)
      response = connection.post do |req|
        req.url "settings/#{setting}/set", {:value => value}
      end
      return_error_or_body(response, response.body.response)
    end
    
  end
end

