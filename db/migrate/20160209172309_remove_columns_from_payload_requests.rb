class RemoveColumnsFromPayloadRequests < ActiveRecord::Migration
  def change
    remove_column :payload_requests, :url
    remove_column :payload_requests, :referredBy
    remove_column :payload_requests, :requestType
    remove_column :payload_requests, :parameters
    remove_column :payload_requests, :eventName
    remove_column :payload_requests, :userAgent
    remove_column :payload_requests, :resolutionWidth
    remove_column :payload_requests, :resolutionHeight
    remove_column :payload_requests, :ip
  end
end
