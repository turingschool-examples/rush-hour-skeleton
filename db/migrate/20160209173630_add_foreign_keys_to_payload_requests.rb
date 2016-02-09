class AddForeignKeysToPayloadRequests < ActiveRecord::Migration
  def change
    add_column :payload_requests, :resolution_id,  :integer
    add_column :payload_requests, :referrer_id,    :integer
    add_column :payload_requests, :url_request_id, :integer
    add_column :payload_requests, :user_data_id,   :integer
  end
end
