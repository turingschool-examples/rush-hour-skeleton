class AddForeignKeyToPayload < ActiveRecord::Migration
  def change
    add_column :payloads, :source_id, :integer
    add_foreign_key :payloads, :sources
  end
end
