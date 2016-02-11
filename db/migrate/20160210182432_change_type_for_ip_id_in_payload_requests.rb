class ChangeTypeForIpIdInPayloadRequests < ActiveRecord::Migration
  def change
    change_column :payload_requests, :ip_id, "integer USING ip_id::integer"
  end
end
