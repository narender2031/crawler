module Api
    class ApiController < ApplicationController
        protect_from_forgery with: :null_session
   
        def authenticate
            authenticate_or_request_with_http_token do |token, options|
                User.exists?(token: token)
                if User.exists?(token: token)
                    @current_user = User.find_by(token: token)
                end
            end
        end
        def current_user
            @current_user
        end
      
    end
  end