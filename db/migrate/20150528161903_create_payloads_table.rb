class CreatePayloadsTable < ActiveRecord::Migration
  def change
    create_table :payloads do |t|
      t.text :url
      t.text :requested_a
    end
  end
end
