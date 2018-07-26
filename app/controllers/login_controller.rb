class LoginController < ApplicationController
    def index
    end
    
    def create
        user = User.find_by(email: params[:email])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            cookies[:token] = user.token
            redirect_to dash_path
        else
            flash['notice']= "Email or password is invalid"
            redirect_to login_path
        end
    end
    def logout
        
        session[:user_id] = nil
        cookies[:token] = nil
        redirect_to login_path
    end
    def g_log
        @url =  request.GET
        user = User.find_by(google_token: params[:g_id])
        if user
            session[:user_id] = user.id
            cookies[:token] = user.token
            redirect_to dash_path
        else
            flash['notice']= "You are not founded"
            redirect_to login_path
        end
        
    end
   
end
