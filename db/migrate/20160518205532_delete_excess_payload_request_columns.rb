class DeleteExcessPayloadRequestColumns < ActiveRecord::Migration
  def change
    remove_column :payload_requests, :url
    remove_column :payload_requests, :request_type
    remove_column :payload_requests, :event_name
    remove_column :payload_requests, :ip
    remove_column :payload_requests, :referred_by
    remove_column :payload_requests, :user_agent_id
    remove_column :payload_requests, :resolution_id
  end
end
