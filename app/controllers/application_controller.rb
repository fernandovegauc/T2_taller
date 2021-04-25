class ApplicationController < ActionController::API
    require "base64"
    
    
    def encoding(name)
        
        encoded = Base64.encode64(name).strip
        return encoded[0..21]

    end

end
