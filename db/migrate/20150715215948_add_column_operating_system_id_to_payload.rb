class AddColumnOperatingSystemIdToPayload < ActiveRecord::Migration
  def change
    add_column :payloads, :operating_system_id, :integer 
  end
end
