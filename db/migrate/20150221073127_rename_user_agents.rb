class RenameUserAgents < ActiveRecord::Migration
  def change
    rename_table :user_agents, :payload_user_agents
  end
end
