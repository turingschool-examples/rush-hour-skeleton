class RenameColumnRequestIdInPayloadRequests < ActiveRecord::Migration
  def change
    rename_column :payload_requests, :requestType, :request_id
  end
end
