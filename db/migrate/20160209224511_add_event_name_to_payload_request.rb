class AddEventNameToPayloadRequest < ActiveRecord::Migration
  def change
    add_column :payload_requests, :eventName, :string
  end
end
