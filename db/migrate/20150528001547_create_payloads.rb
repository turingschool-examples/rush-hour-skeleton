class CreatePayloads < ActiveRecord::Migration
  def change
    create_table :payloads do |t|
      t.text :url
      t.text :requested_at
      t.integer :responded_in
      t.text :referred_by
      t.text :request_type
      t.set :parameters
      t.text :event_name
      t.text :user_agent
      t.text :resolution_width
      t.text :resolution_height
      t.text :ip

      t.timestamps
    end
  end
end
