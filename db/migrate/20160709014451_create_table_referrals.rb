class CreateTableReferrals < ActiveRecord::Migration
  def change
    create_table :referrals do |t|
      t.text :address

      t.timestamps null: false
    end
  end
end
