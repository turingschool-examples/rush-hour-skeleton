class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.text :path
      t.integer :source_id
      t.integer :visits_count
      t.integer :average_response_time

      t.timestamps null: false
    end
  end
end
