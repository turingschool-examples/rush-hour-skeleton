class CreateIdColumns < ActiveRecord::Migration
  def change
    add_column :payload_requests, :id_url, :string
    add_column :payload_requests, :id_referrer, :string
    add_column :payload_requests, :id_request, :string
    add_column :payload_requests, :id_event, :string
    add_column :payload_requests, :id_useragent, :string
    add_column :payload_requests, :id_resolution, :string
    add_column :payload_requests, :id_ip, :string
    add_column :payload_requests, :id_client, :string
  end
end
