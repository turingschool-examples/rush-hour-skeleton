class CreatePayloads < ActiveRecord::Migration
  def change
    create_table :payloads do |t|
      t.integer :url_id
      t.datetime :requested_at
      t.integer :responded_in
      t.integer :referred_by_id
      t.integer :request_type_id
      t.text :parameters
      t.integer :event_name_id
      t.integer :user_agent_id
      t.integer :resolution_id
      t.integer :ip_id
      t.integer :source_id
    end
  end
end
