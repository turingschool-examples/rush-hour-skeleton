class CreatePayloads < ActiveRecord::Migration
  def change
    create_table :payloads do |t|
      t.text :url
      t.text :sha

      t.timestamps
    end
  end
end
