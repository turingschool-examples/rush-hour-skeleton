class RemovePayloads < ActiveRecord::Migration
  def change
    drop_table :payloads
  end
end
