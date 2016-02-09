class CreateReferredBys < ActiveRecord::Migration
  def change
    create_table :referred_bys do |t|
      t.string :referredBy

      t.timestamps null: false
    end
  end
end
