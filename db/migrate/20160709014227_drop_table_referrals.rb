class DropTableReferrals < ActiveRecord::Migration
  def change
    drop_table :referrals
  end
end
