class FixingEverything < ActiveRecord::Migration
  def change
    rename_column :payloads, :requested_at, :requestedAt
    rename_column :payloads, :responded_in, :respondedIn
    rename_column :referers, :url, :referredBy
    rename_column :events, :name, :eventName
    rename_column :resolutions, :height, :resolutionHeight
    rename_column :resolutions, :width, :resolutionWidth
    remove_column :user_agents, :web_browser, :string
    remove_column :user_agents, :OS, :string
    remove_column :user_agents, :OS_version, :string
    add_column :user_agents, :userAgent, :string
    rename_table :user_agents, :agents
    rename_column :ips, :address, :ip
    rename_table :ips, :addresses
    create_table :requests do |t|
      t.string :requestType
    end
  end
end
