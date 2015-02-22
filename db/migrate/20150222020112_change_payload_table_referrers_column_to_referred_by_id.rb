class ChangePayloadTableReferrersColumnToReferredById < ActiveRecord::Migration
  def change
    remove_column :payloads, :referrer_id
    add_column :payloads, :referred_by_id, :integer
  end
end
