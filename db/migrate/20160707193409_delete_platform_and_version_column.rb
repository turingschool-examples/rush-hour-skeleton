class DeletePlatformAndVersionColumn < ActiveRecord::Migration
  def change
    remove_column :software_agents, :version
    remove_column :software_agents, :platform
  end
end
