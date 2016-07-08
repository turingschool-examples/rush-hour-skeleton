class AddUserAgentIdColumnToPayloadRequestsTable < ActiveRecord::Migration
  def change
    add_column :payload_requests, :user_agent_id, :integer
  end
end
