class CreateRefers < ActiveRecord::Migration
  def change
    create_table :refers do |t|
      t.string :referredBy

      t.timestamps null: false
    end
  end
end
