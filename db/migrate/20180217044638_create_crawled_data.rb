class CreateCrawledData < ActiveRecord::Migration[5.1]
  def change
    create_table :crawled_data do |t|
      t.string :full_details_product_url
      t.string :product_image
      t.string :product_name
      t.string :product_price
      t.string :product_type
      t.string :product_rating
      t.string :product_original_price
      t.timestamps
    end
  end
end
