class DataWorker
    include Sidekiq::Worker
    sidekiq_options retry: false
    def perform(current_user)
        @user = User.find(current_user)
        @token = @user.token
        @url = @user.activities.last
        @data = {
            url: @url.crawled_url
        }
        require 'uri'
        require 'net/http'
        
        url = URI("http://localhost:3000/api/test")
        
        http = Net::HTTP.new(url.host, url.port)
        
        request = Net::HTTP::Post.new(url)
        request["authorization"] = 'Token '+@token+''
        request["content-type"] = 'application/json'
        request["cache-control"] = 'no-cache'
        request["postman-token"] = 'ca9c6910-2cf2-c0d8-f478-106976989992'
        request.body = @data.to_json
        
        response = http.request(request)
        puts response.read_body
    end
end