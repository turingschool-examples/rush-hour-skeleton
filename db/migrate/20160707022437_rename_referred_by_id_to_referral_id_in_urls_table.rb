class RenameReferredByIdToReferralIdInUrlsTable < ActiveRecord::Migration
  def change
    rename_column :urls, :referred_by_id, :referral_id
  end
end
