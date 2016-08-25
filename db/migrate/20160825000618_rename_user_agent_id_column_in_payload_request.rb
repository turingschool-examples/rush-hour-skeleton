class RenameUserAgentIdColumnInPayloadRequest < ActiveRecord::Migration
  def change
    rename_column :payload_requests, :user_agent_id, :u_agent_id
  end
end
