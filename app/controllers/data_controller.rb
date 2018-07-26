class DataController < ApplicationController
    before_action :authorize
    def index
        @user = current_user
        @data = current_user.crawled_data.order(created_at: :desc)
        respond_to do |format|
            format.html
            format.csv { send_data @data.to_csv }
          end
    end
end
