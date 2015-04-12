class MoveColumnsOutToNewTables < ActiveRecord::Migration
  def change
    remove_column :payloads, :resolution_width
    remove_column :payloads, :resolution_height
    remove_column :payloads, :user_agent
    add_column :payloads, :screen_resolution_id, :integer

  end
end
