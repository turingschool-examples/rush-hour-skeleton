class ChangeTableNameIdentifierToSources < ActiveRecord::Migration
  def change
    rename_column :identifiers, :title, :identifier
    rename_table :identifiers, :sources
  end
end
