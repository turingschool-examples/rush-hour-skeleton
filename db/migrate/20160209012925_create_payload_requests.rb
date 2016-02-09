class CreatePayloadRequests < ActiveRecord::Migration
  def change
    create_table :payload_requests do |t|
      t.string  :url
      t.date    :requested_at
      t.integer :responded_in
      t.string  :referred_by
      t.string  :request_type
      t.string  :parameters, array: true, default: []
      t.string  :event_name
      t.string  :user_agent
      t.string  :resolution_width
      t.string  :resolution_height
      t.string  :ip
    end
  end
end
