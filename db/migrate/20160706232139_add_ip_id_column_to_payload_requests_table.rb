class AddIpIdColumnToPayloadRequestsTable < ActiveRecord::Migration
  def change
    add_column :payload_requests, :ip_id, :integer
  end
end
