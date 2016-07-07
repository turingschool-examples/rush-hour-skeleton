class RemoveReferredByFromPayloadRequestTable < ActiveRecord::Migration
  def change
    remove_column :payload_requests, :referred_by, :text
  end
end
