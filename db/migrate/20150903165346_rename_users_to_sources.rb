class RenameUsersToSources < ActiveRecord::Migration
  def change
    rename_table :users, :sources
  end
end
