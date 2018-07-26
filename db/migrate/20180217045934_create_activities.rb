class CreateActivities < ActiveRecord::Migration[5.1]
  def change
    create_table :activities do |t|
      t.string :crawled_url
      t.integer :total_crawled_data

      t.timestamps
    end
  end
end
