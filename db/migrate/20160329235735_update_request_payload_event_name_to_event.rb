class UpdateRequestPayloadEventNameToEvent < ActiveRecord::Migration
  def change
    change_table :payload_requests do |t|
      t.remove  :event_name_id
      t.integer :event_id
    end
  end
end
