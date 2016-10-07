class CreatePayloadTable < ActiveRecord::Migration
  def change
    create_table :payloads do |t|

      t.text :url_id
      t.datetime :requested_at
      t.integer :responded_in
      t.text :referred_by_id
      t.integer :request_type_id
      t.string :event_name_id
      t.string :user_agent_id
      t.integer :resolution_width_id
      t.integer :resolution_height_id
      t.string :ip_id

      t.timestamp null: false
    end
  end
end
