class DropPayloadRequests < ActiveRecord::Migration
  def change
    drop_table :payload_requests
  end
end
