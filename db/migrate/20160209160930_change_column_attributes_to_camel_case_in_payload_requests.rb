class ChangeColumnAttributesToCamelCaseInPayloadRequests < ActiveRecord::Migration
  def change
    rename_column :payload_requests, :requested_at,      :requestedAt
    rename_column :payload_requests, :responded_in,      :respondedIn
    rename_column :payload_requests, :referred_by,       :referredBy
    rename_column :payload_requests, :request_type,      :requestType
    rename_column :payload_requests, :event_name,        :eventName
    rename_column :payload_requests, :user_agent,        :userAgent
    rename_column :payload_requests, :resolution_width,  :resolutionWidth
    rename_column :payload_requests, :resolution_height, :resolutionHeight
  end
end
