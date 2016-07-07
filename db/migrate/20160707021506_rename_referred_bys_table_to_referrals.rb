class RenameReferredBysTableToReferrals < ActiveRecord::Migration
  def change
    rename_table :referred_bys, :referrals
  end
end
