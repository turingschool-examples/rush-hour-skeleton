class ChangeTypeForReferrerIdInPayloadRequests < ActiveRecord::Migration
  def change
    change_column :payload_requests, :referrer_id, "integer USING referrer_id::integer"
  end
end
