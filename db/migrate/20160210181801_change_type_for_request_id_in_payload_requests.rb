class ChangeTypeForRequestIdInPayloadRequests < ActiveRecord::Migration
  def change
    change_column :payload_requests, :request_id, "integer USING request_id::integer"
  end
end
