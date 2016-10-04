class FixDataTypesPayloadRequests < ActiveRecord::Migration
  def change
    change_column :payload_requests, :referred_by, 'integer USING CAST(referred_by AS integer)'
    change_column :payload_requests, :request_type, 'integer USING CAST(request_type AS integer)'
    change_column :payload_requests, :ip, 'integer USING CAST(ip AS integer)'
    remove_column(:payload_requests, :resolution_width)
    remove_column(:payload_requests, :resolution_height)
    add_column(:payload_requests, :resolution_id, :integer)
  end
end
