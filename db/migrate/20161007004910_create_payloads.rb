class CreatePayloads < ActiveRecord::Migration
  def change
    create_table :payloads do |t|
      t.integer :url_id
      t.string :requested_at
      t.integer :responded_in
      t.integer :referred_by_id
      t.integer :request_type_id
      t.integer :event_name_id
      t.integer :user_agent_id
      t.integer :resolution_id
      t.integer :ip_id
      t.timestamps null: false
    end
  end
end
