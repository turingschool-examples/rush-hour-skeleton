class RenameUserAgents < ActiveRecord::Migration
  def change
    rename_table("user_agents", "u_agents")
  end
end
