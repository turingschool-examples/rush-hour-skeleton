class CreatePayloads < ActiveRecord::Migration
  def change
    create_table :payloads do |t|
      t.string :url
      t.date :requested_at
      t.integer :responded_in
      t.string :referred_by
      t.string :request_type
      t.string :event_name
      t.text :user_agent
      t.string :resolution_width
      t.string :resolution_height
      t.string :ip
      t.timestamps null: false
    end
  end
end
