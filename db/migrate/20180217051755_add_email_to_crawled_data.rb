class AddEmailToCrawledData < ActiveRecord::Migration[5.1]
  def change
    add_column :crawled_data, :user_id, :integer
  end
end
