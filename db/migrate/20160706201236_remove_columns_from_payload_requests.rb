class RemoveColumnsFromPayloadRequests < ActiveRecord::Migration
  def change
    remove_column :payload_requests, :url, :text
    remove_column :payload_requests, :referredBy, :text
    remove_column :payload_requests, :requestType, :text
    remove_column :payload_requests, :userAgent, :text
    remove_column :payload_requests, :resolutionWidth, :text
    remove_column :payload_requests, :resolutionHeight, :text    
    remove_column :payload_requests, :ip, :text
    rename_column :payload_requests, :requestedAt, :requested_at
    rename_column :payload_requests, :respondedIn, :responded_in
  end
end
