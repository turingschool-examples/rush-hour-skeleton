class CreatePayloadRequests < ActiveRecord::Migration
  def change
    create_table :payload_requests do |t|
      t.text    :url
      t.date    :requested_at
      t.integer :responded_in
      t.text    :referred_by
      t.text    :request_type
      t.text    :user_agent
      t.text    :resolution_width
      t.text    :resolution_height
      t.text    :ip

      t.timestamps null: false
    end
  end
end
