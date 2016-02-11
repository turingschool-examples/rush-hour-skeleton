class AddVerbForeignKeyToPayloadRequests < ActiveRecord::Migration
  def change
    add_column :payload_requests, :verb_id, :integer
  end
end
