class RemoveAgentColumnFromPayloadRequestTable < ActiveRecord::Migration
  def change
    remove_column :payload_requests, :user_agent, :text
  end
end
