class UseForeignKeysInPayloadRequests < ActiveRecord::Migration
  def change
    remove_columns :payload_requests, :referred_by

    add_column :payload_requests, :resolution_id, :integer
    add_column :payload_requests, :user_agent_id, :integer
    add_column :payload_requests, :referral_id, :integer
    add_column :payload_requests, :ip_id, :integer
    add_column :payload_requests, :request_type_id, :integer
    add_column :payload_requests, :url_id, :integer
  end
end
