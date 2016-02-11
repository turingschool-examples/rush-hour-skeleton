class ChangeTypeForResolutionIdInPayloadRequests < ActiveRecord::Migration
  def change
    change_column :payload_requests, :resolution_id, "integer USING resolution_id::integer"
  end
end
