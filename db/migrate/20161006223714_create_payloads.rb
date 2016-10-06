class CreatePayloads < ActiveRecord::Migration
  def change
    create_table :payloads do |t|
      t.string  :url
      t.string  :requested_at
      t.integer :responded_in
      t.string  :referred_by
      t.string  :request_type
      t.string  :event_name
      t.string  :user_agent
      t.string  :resolution_width
      t.string  :resolution_height
      t.string  :ip
    end
  end
end
