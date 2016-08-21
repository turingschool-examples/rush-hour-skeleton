class AddKeyColumnToPayloadRequest < ActiveRecord::Migration
  def change
    add_column :payload_requests, :key, :string
  end
end
