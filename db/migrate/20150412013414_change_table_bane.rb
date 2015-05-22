class ChangeTableBane < ActiveRecord::Migration
  def change
    rename_table :event_name, :event_names
  end
end
