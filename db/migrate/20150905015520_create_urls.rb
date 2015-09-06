class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.text :address
      t.integer :source_id
      t.integer :visits_count, default: 0
      t.integer :average_response_time, default: 0

      t.timestamps null: false
    end
  end
end
