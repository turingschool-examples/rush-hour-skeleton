class CreateUserAgentAndScreenResolutionTable < ActiveRecord::Migration
  def change
    add_column :payloads, :user_agent_id, :integer
    remove_column :user_agents, :os
    rename_column :screen_resolutions, :height, :resolution_height
    rename_column :screen_resolutions, :width, :resolution_width
  end

end
