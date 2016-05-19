class UpdateClientInsidePayloadRequests < ActiveRecord::Migration
  def change
    remove_column :payload_requests, :client_id
    add_column :payload_requests, :client_id, :integer
  end
end
