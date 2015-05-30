class CreatePayloads < ActiveRecord::Migration
  def change
    create_table :payloads do |t|
      t.text :sha

      t.timestamps null: false
    end
  end
end
