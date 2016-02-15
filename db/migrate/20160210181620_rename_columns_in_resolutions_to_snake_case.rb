class RenameColumnsInResolutionsToSnakeCase < ActiveRecord::Migration
  def change
    rename_column :resolutions, :resolutionWidth,  :resolution_width
    rename_column :resolutions, :resolutionHeight, :resolution_height
  end
end
