class RenameColumnsInPayloadRequestsToSnakeCase < ActiveRecord::Migration
  def change
    rename_column :payload_requests, :requestedAt, :requested_at
    rename_column :payload_requests, :respondedIn, :responded_in
    rename_column :payload_requests, :eventName, :event_name
  end
end
