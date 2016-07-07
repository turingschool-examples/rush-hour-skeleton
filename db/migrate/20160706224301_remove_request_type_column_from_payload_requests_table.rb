class RemoveRequestTypeColumnFromPayloadRequestsTable < ActiveRecord::Migration
  def change
    remove_column :payload_requests, :request_type, :text
  end
end
