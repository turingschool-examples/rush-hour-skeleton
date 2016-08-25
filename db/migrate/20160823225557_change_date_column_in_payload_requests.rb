class ChangeDateColumnInPayloadRequests < ActiveRecord::Migration
  def change
    remove_column :payload_requests, :requested_at
    add_column :payload_requests, :requested_at, :datetime
  end
end
