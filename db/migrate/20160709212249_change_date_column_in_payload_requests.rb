class ChangeDateColumnInPayloadRequests < ActiveRecord::Migration
  def change
    change_column :payload_requests, :requested_at, 'text USING CAST(requested_at AS text)'
  end
end
