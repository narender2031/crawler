class RegisterController < ApplicationController
    def index
        @register = User.new
    end
    
    def create
        @user = User.new
        if user_params[:first_name].blank?
            redirect_to register_path
        elsif user_params[:last_name].blank?
            redirect_to register_path
        elsif user_params[:email].blank?
            redirect_to register_path
        elsif user_params[:password].blank?
            redirect_to register_path  
        elsif user_params[:phone].blank?

        elsif User.exists?(email: user_params[:email])
            redirect_to register_path
        else
            @user.first_name = user_params[:first_name]
            @user.last_name = user_params[:last_name]
            @user.email = user_params[:email]
            @user.phone = user_params[:phone]
            @user.password = user_params[:password]
            if @user.save
                if @user && @user.authenticate(user_params[:password])
                    session[:user_id] = @user.id
                    cookies[:token] = @user.token
                    puts "Anku"
                    redirect_to dash_path
                    
                else
                    puts "Studpid"
                    flash.now.alert = "Email or password is invalid"
                    redirect_to register_path
                end
            end    
        end    
    end
    private
    def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :password, :phone)
    end
end
