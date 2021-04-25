class ApplicationController < ActionController::API
    require "base64"
    
    
    def encoding(name)
        
        encoded = Base64.encode64(name).strip
        return encoded.truncate(22)

    end

end
