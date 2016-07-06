class AddUrlIdToPayloadRequests < ActiveRecord::Migration
  def change
    add_column :payload_requests, :url_id, :integer
  end
end
