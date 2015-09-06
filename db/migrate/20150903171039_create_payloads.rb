class CreatePayloads < ActiveRecord::Migration
  def change
    create_table :payloads do |t|
      t.integer :source_id
      t.string :digest

      t.timestamps null: false
    end
  end
end
