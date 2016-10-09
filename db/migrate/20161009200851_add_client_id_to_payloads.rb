class AddClientIdToPayloads < ActiveRecord::Migration
  def change
    add_column :payloads, :client_id, :integer
  end
end
