class AddIpAddressIdColumnToPayloadRequests < ActiveRecord::Migration

  def change
    add_column :payload_requests, :ip_address_id, :integer
  end
end
