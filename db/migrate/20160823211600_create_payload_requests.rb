class CreatePayloadRequests < ActiveRecord::Migration
  def change
    create_table :payload_requests do |t|
      t.string :url
      t.string :requested_at
      t.integer :responded_in
      t.string :referred_by
      t.string :request_type
      t.string :u_agent
      t.integer :resolution_width
      t.integer :resolution_height
      t.string :ip

      t.timestamps null: false
    end
  end
end
