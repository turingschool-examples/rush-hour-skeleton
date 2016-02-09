class RenameColumnRespondedInPayloadRequest < ActiveRecord::Migration
  def change
    rename_column :payload_requests, :respondedIn, :responded_in
  end
end
