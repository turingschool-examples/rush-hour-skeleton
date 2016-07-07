class RenameUserAgentsToSoftwareAgents < ActiveRecord::Migration
  def change
    rename_table :user_agents, :software_agents
  end
end
