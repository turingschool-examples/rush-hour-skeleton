class RenameColumnIpInPayloadRequests < ActiveRecord::Migration
  def change
    rename_column :payload_requests, :ip, :ip_id
  end
end
