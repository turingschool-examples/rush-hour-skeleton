class ReferredBys < ActiveRecord::Migration
  def change
    create_table :referred_bys do |t|
      t.text :address

      t.timestamps null: false
    end
  end
end
