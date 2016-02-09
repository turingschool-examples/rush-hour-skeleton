class UpdateUserDataIdToUserAgentIdOnPayloadRequests < ActiveRecord::Migration
  def change
    rename_column :payload_requests, :user_data_id, :user_agent_id
  end
end
