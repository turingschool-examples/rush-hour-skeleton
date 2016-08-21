class ChangeUserAgentTableName < ActiveRecord::Migration
  def change
    rename_table("user_agents", "user_agent_bs")
  end
end
