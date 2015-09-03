class SubUrls < ActiveRecord::Migration
  def change
    create_table :sub_urls do |t|
      t.text :sub_url

      t.timestamps null: false
    end
  end
end
