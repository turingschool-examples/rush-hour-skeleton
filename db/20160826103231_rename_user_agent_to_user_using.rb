class RenameUserAgentToUserUsing < ActiveRecord::Migration
  def change
    rename_table :user_agents, :user_usings
    rename_column :payload_requests, :user_agent_id, :user_using_id
  end
end
