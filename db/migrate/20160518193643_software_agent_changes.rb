class SoftwareAgentChanges < ActiveRecord::Migration
  def change
    rename_table(:user_agents, :software_agents)
    rename_column(:payload_requests, :user_agent_id, :software_agent_id)
  end
end
