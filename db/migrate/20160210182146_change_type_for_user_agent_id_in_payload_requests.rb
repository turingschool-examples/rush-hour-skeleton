class ChangeTypeForUserAgentIdInPayloadRequests < ActiveRecord::Migration
  def change
    change_column :payload_requests, :user_agent_id, "integer USING user_agent_id::integer"
  end
end
