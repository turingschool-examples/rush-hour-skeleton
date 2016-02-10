class ChangeTypeForUrlIdInPayloadRequests < ActiveRecord::Migration
  def change
    change_column :payload_requests, :url_id, "integer USING url_id::integer"
  end
end
