class ChangeIdColumnsInPayloadRequestsToInteger < ActiveRecord::Migration

  def change
    change_column :payload_requests, :url_id, 'integer USING CAST(url_id AS integer)'
    change_column :payload_requests, :referral_id, 'integer USING CAST(referral_id AS integer)'
    change_column :payload_requests, :request_type_id, 'integer USING CAST(request_type_id AS integer)'
    change_column :payload_requests, :user_agent_device_id, 'integer USING CAST(user_agent_device_id AS integer)'
    change_column :payload_requests, :resolution_id, 'integer USING CAST(resolution_id AS integer)'
    change_column :payload_requests, :ip_id, 'integer USING CAST(ip_id AS integer)'
  end
end
