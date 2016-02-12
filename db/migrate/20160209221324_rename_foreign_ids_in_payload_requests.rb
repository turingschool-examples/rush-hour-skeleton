class RenameForeignIdsInPayloadRequests < ActiveRecord::Migration
  def change
    rename_column :payload_requests, :url, :url_id
    rename_column :payload_requests, :eventName, :event_name_id
    rename_column :payload_requests, :ip, :ip_id
    rename_column :payload_requests, :requestType, :request_type_id
    rename_column :payload_requests, :referredBy, :referred_by_id
    rename_column :payload_requests, :userAgent, :user_agent_id
    add_column :payload_requests, :resolution_id, :integer
    remove_column :payload_requests, :resolutionWidth
    remove_column :payload_requests, :resolutionHeight
  end
end
