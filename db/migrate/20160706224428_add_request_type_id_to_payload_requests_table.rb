class AddRequestTypeIdToPayloadRequestsTable < ActiveRecord::Migration
  def change
    add_column :payload_requests, :request_type_id, :integer
  end
end
