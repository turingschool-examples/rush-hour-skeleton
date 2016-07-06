class AddColumnsToPayloadRequests < ActiveRecord::Migration
  def change
    add_column :payload_requests, :url_id, :text
    add_column :payload_requests, :referral_id, :text
    add_column :payload_requests, :request_type_id, :text
    add_column :payload_requests, :user_agent_id, :text
    add_column :payload_requests, :resolution_id, :text
    add_column :payload_requests, :ip_id, :text
  end
end
