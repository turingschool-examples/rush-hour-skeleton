class RenameColumnRequestedInToRespondedInToPayloadRequest < ActiveRecord::Migration
  def change
    rename_column :payload_requests, :requested_in, :responded_in
  end
end
