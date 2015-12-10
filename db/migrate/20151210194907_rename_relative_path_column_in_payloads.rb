class RenameRelativePathColumnInPayloads < ActiveRecord::Migration
  def change
    rename_column :payloads, :relative_path, :relative_path_string
  end
end
