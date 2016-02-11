class ChangeUserAgentToUserSystem < ActiveRecord::Migration
  def change
    rename_column :payload_requests, :user_agent_id, :user_system_id
    rename_table :user_agents, :user_systems
  end
end
