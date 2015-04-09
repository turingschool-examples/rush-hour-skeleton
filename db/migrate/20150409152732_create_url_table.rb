class CreateUrlTable < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.string :name
      t.integer :payload_id
    end
  end
end
