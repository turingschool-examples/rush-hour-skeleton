class RenameColumnResolutionWidthInPayloadRequests < ActiveRecord::Migration
  def change
    rename_column :payload_requests, :resolutionWidth, :resolution_id 
  end
end
