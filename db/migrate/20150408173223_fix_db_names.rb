class FixDbNames < ActiveRecord::Migration
  def change
    rename_column :clients, :root_url, :root_url
    rename_column :events, :eventName, :event_name
    rename_column :agents, :userAgent, :user_agent
    rename_column :payloads, :respondedIn, :responded_in
    rename_column :payloads, :requestedAt, :requested_at
    rename_column :referers, :referredBy, :referred_by
    rename_column :requests, :requestType, :request_type
    rename_column :resolutions, :resolutionHeight, :resolution_height
    rename_column :resolutions, :resolutionWidth, :resolution_width
  end
end
