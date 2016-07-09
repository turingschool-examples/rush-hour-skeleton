class RenameBrowserColumnToMessage < ActiveRecord::Migration
  def change
    rename_column :software_agents, :browser, :message
  end
end
