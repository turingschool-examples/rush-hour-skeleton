class CreatePayloads < ActiveRecord::Migration
  def change
    create_table :payloads do |t|
      t.text :resolution_width
      t.text :resolution_height
      t.text :requested_at
      t.integer :responded_in
      t.integer :url_id
      t.integer :event_id
      t.integer :referrer_id
      t.integer :browser_id
      t.integer :platform_id
      t.integer :request_type_id

      t.timestamps
    end
  end
end
