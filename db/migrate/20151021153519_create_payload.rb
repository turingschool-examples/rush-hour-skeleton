class CreatePayload < ActiveRecord::Migration
  def change
    create_table :payloads do |t|
      t.text :url
      t.text :requested_at
      t.text :responded_in
      t.text :reffered_by
      t.text :request_type
      t.text :parameters
      t.text :event_name
      t.text :user_agent
      t.integer :resolution_width
      t.integer :resolution_height
      t.text :ip
    end
  end
end
