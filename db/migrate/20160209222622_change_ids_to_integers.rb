class ChangeIdsToIntegers < ActiveRecord::Migration
  def change
    change_table :payload_requests do |t|
      change_column :payload_requests, :event_name_id, 'integer USING CAST(event_name_id AS integer)'
      change_column :payload_requests, :ip_id, 'integer USING CAST(ip_id AS integer)'
      change_column :payload_requests, :referred_by_id, 'integer USING CAST(referred_by_id AS integer)'
      change_column :payload_requests, :request_type_id, 'integer USING CAST(request_type_id AS integer)'
      change_column :payload_requests, :user_agent_id, 'integer USING CAST(user_agent_id AS integer)'
      change_column :payload_requests, :url_id, 'integer USING CAST(url_id AS integer)'
    end
  end
end
