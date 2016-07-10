class RenameUserAgentIdInPayloadRequest < ActiveRecord::Migration
  def change
    rename_column :payload_requests, :user_agent_id, :user_agent_device_id
  end
end
