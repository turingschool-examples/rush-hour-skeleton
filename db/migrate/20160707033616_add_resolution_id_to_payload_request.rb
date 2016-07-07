class AddResolutionIdToPayloadRequest < ActiveRecord::Migration
  def change
    add_column :payload_requests, :resolution_id, :integer
  end
end
