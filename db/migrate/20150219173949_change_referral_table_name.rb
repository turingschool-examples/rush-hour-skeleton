class ChangeReferralTableName < ActiveRecord::Migration
  def change
    rename_table :referred_by, :referrals 
  end
end
