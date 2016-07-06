class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.text    :address
      t.integer :referred_by_id

      t.timestamps null: false
    end
  end
end
