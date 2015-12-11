class RenameOperatingSystemAndAddOperatingSystemIdInPayloads < ActiveRecord::Migration
  def change
    rename_column :payloads, :operating_system, :operating_system_string
    add_column :payloads, :operating_system_id, :integer
  end
end
