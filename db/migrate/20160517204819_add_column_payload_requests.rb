class AddColumnPayloadRequests < ActiveRecord::Migration
  def change
    add_column :payload_requests, :request_type, :string
  end
end
