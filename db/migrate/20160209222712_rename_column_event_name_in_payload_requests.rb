class RenameColumnEventNameInPayloadRequests < ActiveRecord::Migration
  def change
    rename_column :payload_requests, :eventName, :event_id
  end
end
