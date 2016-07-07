class UpdateColumnsInPayloadRequests < ActiveRecord::Migration
  def change
    remove_column :payload_requests, :url, :text
    remove_column :payload_requests, :referred_by, :text
    remove_column :payload_requests, :request_type, :string
    remove_column :payload_requests, :user_agent, :text
    remove_column :payload_requests, :resolution_width, :string
    remove_column :payload_requests, :resolution_height, :string
    remove_column :payload_requests, :ip, :string
    add_column :payload_requests, :url_id, :integer
    add_column :payload_requests, :referred_by_id, :integer
    add_column :payload_requests, :request_type_id, :integer
    add_column :payload_requests, :u_agent_id, :integer
    add_column :payload_requests, :resolution_id, :integer
    add_column :payload_requests, :ip_id, :integer
  end
end
