class RenameUserAgentTable < ActiveRecord::Migration
  def change
    rename_table :user_agents, :user_agent_devices
  end
end
