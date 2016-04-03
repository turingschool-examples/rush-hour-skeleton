class CreateReferrers < ActiveRecord::Migration
  def change
    create_table :referrers do |t|
      t.string :address

      t.timestamps null: false
    end
  end
end
