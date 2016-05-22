class UpdatePayloadRequestsTable < ActiveRecord::Migration
  def change
    remove_column :payload_requests, :url
    remove_column :payload_requests, :referred_by
    remove_column :payload_requests, :request_type
    remove_column :payload_requests, :event_name
    remove_column :payload_requests, :user_agent
    remove_column :payload_requests, :resolution_width
    remove_column :payload_requests, :resolution_height
    remove_column :payload_requests, :ip

    add_column    :payload_requests, :url_id,          :integer
    add_column    :payload_requests, :referrer_id,     :integer
    add_column    :payload_requests, :request_type_id, :integer
    add_column    :payload_requests, :event_name_id,   :integer
    add_column    :payload_requests, :user_agent_id,   :integer
    add_column    :payload_requests, :resolution_id,   :integer
    add_column    :payload_requests, :ip_id,           :integer
  end
end
