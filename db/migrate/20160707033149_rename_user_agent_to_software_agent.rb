class RenameUserAgentToSoftwareAgent < ActiveRecord::Migration
  def change
    rename_column :payload_requests, :user_agent_id, :software_agent_id
  end
end
