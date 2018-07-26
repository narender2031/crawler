class DashController < ApplicationController
    before_action :authorize
    def index
        @user = current_user
        @crawel = current_user.activities.new
        @activity = current_user.activities.limit(10).order(created_at: :desc)
        @activity_count = current_user.activities.count
        if current_user.crawled_data.blank?
            @crawled_data =  0 
        else
            @crawled_data = current_user.crawled_data.count
        end  
            @crawel_data_per_day = current_user.crawled_data
    end
    
    def crawel
        @crawel = current_user.activities.new
        @crawel.crawled_url = activities_params[:crawled_url]
        @crawel.save
        
        DataWorker.perform_async(current_user.id)
        
        flash[:notice] = "Url is added for Crawel Please wait or visit data tab.." 
        redirect_to dash_path
    end
    private
    def activities_params
        params.require(:activity).permit(:crawled_url, :total_crawled_data)
    end
end
