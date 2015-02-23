class EditEventTable < ActiveRecord::Migration
  def change
    remove_column :payloads, :eventName
    add_column :payloads, :event_id, :integer
    add_column :events, :payload_id, :integer
  end
end
