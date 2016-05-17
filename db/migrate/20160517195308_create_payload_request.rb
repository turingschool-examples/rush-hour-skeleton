class CreatePayloadRequest < ActiveRecord::Migration
  def change
    create_table "payload_requests" do |t|
      t.text    :url
      t.text    :requested_at
      t.integer :responded_in
      t.string  :request_type
      t.text    :parameters
      t.string  :event_name
      t.text    :user_agent
      t.string  :resolution_width
      t.string  :resolution_height
      t.string  :ip
      t.string  :referred_by
      t.timestamps null: true
    end
  end
end
