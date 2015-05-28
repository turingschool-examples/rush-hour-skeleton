class RenamePayloadColumns < ActiveRecord::Migration
  def change
    rename_column :payloads, :requestedAt,      :requested_at
    rename_column :payloads, :respondedIn,      :responded_in
    rename_column :payloads, :referredBy,       :referred_by
    rename_column :payloads, :requestType,      :request_type
    rename_column :payloads, :eventName,        :event_name
    rename_column :payloads, :userAgent,        :user_agent
    rename_column :payloads, :resolutionWidth , :resolution_width
    rename_column :payloads, :resolutionHeight, :resolution_height
  end
end
