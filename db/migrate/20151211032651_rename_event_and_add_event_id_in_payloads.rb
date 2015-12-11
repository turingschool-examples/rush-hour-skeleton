class RenameEventAndAddEventIdInPayloads < ActiveRecord::Migration
  def change
    rename_column :payloads, :event, :event_string
    add_column :payloads, :event_id, :integer
  end
end
