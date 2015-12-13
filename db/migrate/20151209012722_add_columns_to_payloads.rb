class AddColumnsToPayloads < ActiveRecord::Migration
  def change
    add_column :payloads, :application_id, :integer
    add_column :payloads, :relative_path, :string
    add_column :payloads, :requested_at, :datetime
    add_column :payloads, :responded_in, :integer
    add_column :payloads, :referred_by, :string
    add_column :payloads, :request_type, :string
    add_column :payloads, :event, :string
    add_column :payloads, :operating_system, :string
    add_column :payloads, :browser, :string
    add_column :payloads, :resolution, :string
    add_column :payloads, :ip_address, :string
  end
end
