class AddClientIdToPayloads < ActiveRecord::Migration
  def change
    add_reference :payloads, :client, index: true, foreign_key: true
  end
end
