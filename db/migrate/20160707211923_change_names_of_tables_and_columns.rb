class ChangeNamesOfTablesAndColumns < ActiveRecord::Migration
  def change
    rename_column :payload_requests, :referred_by, :referred_by_id
    rename_column :payload_requests, :user_agent, :software_agent_id
    rename_column :payload_requests, :request_type, :request_type_id
    rename_column :payload_requests, :ip, :ip_id
    rename_table :software_agent, :software_agents
  end
end
