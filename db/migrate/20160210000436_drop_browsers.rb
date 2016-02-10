class DropBrowsers < ActiveRecord::Migration
  def change
    drop_table(:browsers)
  end
end
