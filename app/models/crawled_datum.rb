class CrawledDatum < ApplicationRecord
    belongs_to :user
    require 'csv'
    def self.to_csv(options = {})
    desired_columns = ["product_name", "product_image", "full_details_product_url", "product_price", "product_original_price", "product_rating", "product_type"]
        CSV.generate(options) do |csv|
            csv << desired_columns
            all.each do |product|
                csv << product.attributes.values_at(*desired_columns)
            end
        end
    end
end
