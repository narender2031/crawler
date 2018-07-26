class ActivityController < ApplicationController
    before_action :authorize
    def index
        @user = current_user
        @activity = current_user.activities.all
    end
end
