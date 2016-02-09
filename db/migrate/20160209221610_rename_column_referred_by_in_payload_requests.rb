class RenameColumnReferredByInPayloadRequests < ActiveRecord::Migration
  def change
    rename_column :payload_requests, :referredBy, :referrer_id
  end
end
