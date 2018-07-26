class User < ApplicationRecord
    has_secure_password
    validates_uniqueness_of :email
    before_create :generate_access_token
    mount_uploader :inage, ImageUploader
    has_many :crawled_data
    has_many :activities
    private
    def generate_access_token
        begin
            self.token = SecureRandom.hex
        end while self.class.exists?(token: token)
    end
end
