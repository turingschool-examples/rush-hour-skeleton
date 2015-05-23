class InsertRelationships < ActiveRecord::Migration
  def change
    add_column :payloads, :address_id, :integer
    add_column :payloads, :agent_id, :integer
    add_column :payloads, :client_id, :integer
    add_column :payloads, :event_id, :integer
    add_column :payloads, :referer_id, :integer
    add_column :payloads, :request_id, :integer
    add_column :payloads, :resolution_id, :integer
    add_column :payloads, :tracked_site_id, :integer
  end
end
