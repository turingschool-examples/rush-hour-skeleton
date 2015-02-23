class RenameUserAgentToAgentInPayloadAndOwnTable < ActiveRecord::Migration
  def change
    rename_table :user_agents, :agents
    rename_column :payloads, :user_agent_id, :agent_id
  end
end
