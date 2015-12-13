class CreatePayloads < ActiveRecord::Migration
  def change
    create_table :payloads do |t|
      t.string    :path
      t.string    :referred_by
      t.string    :request_type
      t.string    :parameters
      t.integer   :responded_in
      t.string    :requested_at
      t.string    :event_name
      t.string    :web_browser
      t.string    :operating_system
      t.integer   :resolution_width
      t.integer   :resolution_height
      t.string    :ip_address
      t.string    :hexed_payload
      t.integer   :client_id

      t.timestamps null: false
    end
  end
end
