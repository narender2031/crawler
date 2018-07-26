class Api::GoogleController < Api::ApiController
    def googleAuth
        user = User.find_by(email: params[:email])
        if user 
            if user.google_token == params[:token_id]
                session[:user_id] = user.id
                cookies[:token] = user.token
                render json: {message: "login"}
            else
                render json: {message: "Token not match"}
            end
           
        elsif user.blank?
            @user = User.new
            @user.email = params[:email]
            @user.first_name = params[:fname]
            @user.last_name = params[:lname]
            @user.google_token = params[:token_id]
            @user.password = "12345678"
            if @user.save
                session[:user_id] = @user.id
                cookies[:token] = @user.token
                render json: {message: "login"}
            else
                render json: {message: "Fail"}
            end
        end    
    end
end    