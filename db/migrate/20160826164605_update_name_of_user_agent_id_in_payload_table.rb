class UpdateNameOfUserAgentIdInPayloadTable < ActiveRecord::Migration
  def change
    rename_column(:payload_requests, :user_agent_id, :system_information_id)
  end
end
