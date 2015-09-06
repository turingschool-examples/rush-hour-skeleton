class RenameUserIdColumnToBrowserIdColumn < ActiveRecord::Migration
  def change
    rename_column :payloads, :user_agent_id, :browser_id
  end
end
