class AddEventNameIdToPayloads < ActiveRecord::Migration
  def change
    add_column :payloads, :event_name_id, :integer
  end
end
