class DropSourcesTable < ActiveRecord::Migration
  def change
    drop_table :sources
  end
end
