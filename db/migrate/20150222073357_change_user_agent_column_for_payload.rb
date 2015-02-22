class ChangeUserAgentColumnForPayload < ActiveRecord::Migration
  def change
    rename_column :payloads, :user_agent_id, :payload_user_agent_id
  end
end
