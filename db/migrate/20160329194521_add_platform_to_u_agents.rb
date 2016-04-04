class AddPlatformToUAgents < ActiveRecord::Migration
  def change
    add_column :u_agents, :platform, :string
  end
end
