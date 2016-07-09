class AddVersionAndPlatformColumnsToSoftwareAgents < ActiveRecord::Migration
  def change
    add_column :software_agents, :version, :text
    add_column :software_agents, :platform, :text
  end
end
