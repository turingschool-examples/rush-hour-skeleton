class RenameResolutionsAndAddResolutionIdInPayloads < ActiveRecord::Migration
  def change
    rename_column :payloads, :resolution, :resolution_string
    add_column :payloads, :resolution_id, :integer
  end
end
