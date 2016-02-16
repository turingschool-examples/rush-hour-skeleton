class UpdateTableNames < ActiveRecord::Migration
  def change
    rename_table :url, :urls
    rename_table :event_name, :event_names
    rename_table :ip, :ips
    rename_table :referrred, :referreds
    rename_table :screen_resolution, :screen_resolutions
    rename_table :user_agent, :user_agents
  end
end
