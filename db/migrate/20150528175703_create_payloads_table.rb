class CreatePayloadsTable < ActiveRecord::Migration
  def change
    create_table :payloads do |t|
      t.text :payhash
      t.belongs_to :source
    end
  end
end

