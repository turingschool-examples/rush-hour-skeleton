class AddPlatformToUserAgents < ActiveRecord::Migration
  def change
    add_column :user_agents, :platform, :string
  end
end
