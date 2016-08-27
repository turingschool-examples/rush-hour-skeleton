class UpdatePayloadRequestsWithIpIdAndUserAgentsRename < ActiveRecord::Migration
  def change
    remove_column :payload_requests, :ip, :string

    add_reference :payload_requests, :ip, index: true

    rename_column :payload_requests, :user_agent_id, :u_agent_id
  end
end
