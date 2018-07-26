class ProfileController < ApplicationController
    before_action :authorize
    def index
        @user = current_user
    end

    def updateProfile
        @user = current_user
        if user_params[:email] == current_user.email || user_params[:phone] == current_user.phone
            if @user.update(user_params)
                redirect_to profile_path
            else
                redirect_to activity_path
            end
        elsif User.exists?(email: user_params[:email])
            redirect_to dash_path

        elsif User.exists?(phone: user_params[:phone])
            redirect_to dash_path
        else
            if @user.update(user_params)
                redirect_to profile_path
            else
                redirect_to activity_path
            end
        end    
    end

    def password
        @password = current_user
    end

    def updatePassword
        if password_params[:new_password] != password_params[:confirm_password]
            redirect_to profile_path
        elsif current_user.authenticate(password_params[:current_password])
            current_user.password = password_params[:new_password]
            current_user.save
            redirect_to password_path
        else
            redirect_to password_path
        end
    end

    private
    def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :phone, :image)
    end
    def password_params 
        params.require(:user).permit(:current_password, :new_password, :confirm_password)
    end
end
