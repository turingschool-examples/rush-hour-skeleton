class RenameColumnRequestedAtInPayloadRequests < ActiveRecord::Migration
  def change
    rename_column :payload_requests, :requestedAt, :requested_at
  end
end
