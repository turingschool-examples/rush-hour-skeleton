class UpdatePayloadRequestSoftwareAgentInteger < ActiveRecord::Migration
  def change
    remove_column(:payload_requests, :software_agent_id)
    add_column(:payload_requests, :software_agent_id, :integer)
  end
end
