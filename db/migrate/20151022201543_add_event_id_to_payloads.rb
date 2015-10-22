class AddEventIdToPayloads < ActiveRecord::Migration
  def change
    add_column :payloads, :event_id, :integer
  end
end
