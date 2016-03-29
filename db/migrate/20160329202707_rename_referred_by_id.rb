class RenameReferredById < ActiveRecord::Migration
  def change
    change_table :payload_requests do |t|
      t.remove  :referred_by_id
      t.integer :referral_id
    end
  end
end
