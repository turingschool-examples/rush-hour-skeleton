class RenamePayloadRequestColumnToReferrerUrlId < ActiveRecord::Migration
  def change
    rename_column :payload_requests, :referred_by_id, :referrer_url_id
  end
end
