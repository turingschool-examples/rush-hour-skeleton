class RemoveColumnResolutionHeightInPayloadRequests < ActiveRecord::Migration
  def change
    remove_column :payload_requests, :resolutionHeight
  end
end
