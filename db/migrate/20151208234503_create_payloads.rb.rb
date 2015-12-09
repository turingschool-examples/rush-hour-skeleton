class CreatePayloads < ActiveRecord::Migration
  def change
    create_table :payloads do |t|
      t.integer  :user_id
      t.string   :url
      t.string   :requested_at
      t.integer  :responded_in
      t.string   :referred_by
      t.string   :request_type
      t.string   :paramaters
      t.string   :event_name
      t.string   :user_agent
      t.integer  :resolution_id
      t.integer  :ip
      t.string   :payload_sha
    end
  end
end
