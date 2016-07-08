class AddClientIdToPayloadRequestsTable < ActiveRecord::Migration
  def change
    add_column :payload_requests, :client_id, :integer
  end
end
