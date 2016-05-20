class UpdatePayloadRequestTableWithNewAttributeIds < ActiveRecord::Migration
  def change
    remove_column :payload_requests, :requested_at
    remove_column :payload_requests, :responded_in
    remove_column :payload_requests, :parameters

    add_column :payload_requests, :requested_at_id, :integer
    add_column :payload_requests, :responded_in_id, :integer
    add_column :payload_requests, :parameter_id, :integer
  end
end
