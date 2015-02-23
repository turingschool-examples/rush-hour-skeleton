class RenamePayloadsColumnEventName < ActiveRecord::Migration
  def change
    rename_column :payloads, :event_name_id, :event_id
  end
end
