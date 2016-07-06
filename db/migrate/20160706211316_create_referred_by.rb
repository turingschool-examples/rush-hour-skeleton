class CreateReferredBy < ActiveRecord::Migration
  def change
    create_table :referrals do |t|
      t.text :name

      t.timestamps null:false 
    end
  end
end
