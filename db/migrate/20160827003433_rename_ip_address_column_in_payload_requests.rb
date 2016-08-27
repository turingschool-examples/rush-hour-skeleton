class RenameIpAddressColumnInPayloadRequests < ActiveRecord::Migration
  def change
    rename_column :payload_requests, :ip_id, :ip_address_id
  end
end
