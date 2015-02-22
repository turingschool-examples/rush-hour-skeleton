class RenameReferrersTableToReferredBy < ActiveRecord::Migration
  def change
    drop_table :referrers
    create_table :referred_bys do |t|
      t.text :name
    end
  end
end
