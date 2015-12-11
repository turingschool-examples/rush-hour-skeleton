class DropColumnsStringsInPayloads < ActiveRecord::Migration
  def change
    remove_column :payloads, :relative_path_string
    remove_column :payloads, :request_type_string
    remove_column :payloads, :event_string
    remove_column :payloads, :operating_system_string
    remove_column :payloads, :browser_string
    remove_column :payloads, :resolution_string
  end
end
