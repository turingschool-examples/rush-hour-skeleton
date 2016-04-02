class UpdatePayloadRequest < ActiveRecord::Migration
  def change
    change_table :payload_requests do |t|
      t.remove :url,
               :responded_in,
               :referred_by,
               :request_type,
               :parameters,
               :event_name,
               :user_agent,
               :resolution_width,
               :resolution_height,
               :ip
      t.integer :url_id
      t.integer :responded_in_id
      t.integer :referred_by_id
      t.integer :request_type_id
      t.integer :parameter_id
      t.integer :event_name_id
      t.integer :user_agent_id
      t.integer :resolution_id
      t.integer :ip_id
    end
  end
end
