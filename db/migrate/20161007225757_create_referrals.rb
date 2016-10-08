class CreateReferrals < ActiveRecord::Migration
  def change
    create_table :referrals do |t|
      t.string  :source

      t.timestamps  null: false
    end 
  end
end
