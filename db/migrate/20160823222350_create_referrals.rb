class CreateReferrals < ActiveRecord::Migration
  def change
    create_table :referrals do |t|
      t.text :referred_by

      t.timestamps null:false
    end
  end
end
