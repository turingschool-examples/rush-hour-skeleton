class ChangeTypeForEventIdInPayloadRequests < ActiveRecord::Migration
  def change
    change_column :payload_requests, :event_id, "integer USING event_id::integer"
  end
end
