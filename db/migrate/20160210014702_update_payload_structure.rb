class UpdatePayloadStructure < ActiveRecord::Migration
  def change
    change_table :payloads do |t|
      t.rename :url, :url_id
      t.rename :requestedAt, :requested_at
      t.rename :respondedIn, :responded_in
      t.rename :eventName, :event_name_id
      t.rename :ip, :ip_id
      t.rename :referredBy, :referred_id
    end
  end
end
