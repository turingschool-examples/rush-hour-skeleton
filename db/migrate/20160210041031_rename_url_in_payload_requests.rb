class RenameUrlInPayloadRequests < ActiveRecord::Migration
  def change
    rename_column :payload_requests, :url, :url_id
  end
end
