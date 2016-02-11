class RenameColumnUserAgentInPayloadRequests < ActiveRecord::Migration
  def change
    rename_column :payload_requests, :userAgent, :user_agent_id
  end
end
