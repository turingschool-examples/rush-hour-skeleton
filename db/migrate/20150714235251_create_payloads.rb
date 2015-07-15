class CreatePayloads < ActiveRecord::Migration
  def change
    create_table :payloads do |t|
      t.string :digest
      t.integer :source_id  
    end
  end
end
