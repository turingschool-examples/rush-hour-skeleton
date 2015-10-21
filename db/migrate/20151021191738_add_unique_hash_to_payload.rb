class AddUniqueHashToPayload < ActiveRecord::Migration
  def change
    add_column :payloads, :unique_hash, :string 
  end
end
