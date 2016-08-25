class RecreatePayloadRequests < ActiveRecord::Migration
  def change
    create_table :payload_requests do |t|
      t.integer :target_url_id
      t.integer :referrer_url_id
      t.integer :request_type_id
      t.integer :user_agent_id
      t.integer :resolution_id
      t.integer :ip_id
      t.integer :responded_in
      t.datetime :requested_at

      t.timestamps null: false
    end
  end
end
