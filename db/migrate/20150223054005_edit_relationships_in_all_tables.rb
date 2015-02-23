class EditRelationshipsInAllTables < ActiveRecord::Migration
  def change
    remove_column :events, :payload_id
    remove_column :urls, :payload_id
    remove_column :payloads, :ip
    remove_column :payloads, :resolutionWidth
    remove_column :payloads, :resolutionHeight
    add_column :payloads, :ip_id, :integer
    add_column :payloads, :resolution_id, :integer
    add_foreign_key :payloads, :ips
    add_foreign_key :payloads, :events
    add_foreign_key :payloads, :resolutions
  end
end
