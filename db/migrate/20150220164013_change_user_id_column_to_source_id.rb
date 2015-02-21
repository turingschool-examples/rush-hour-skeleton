class ChangeUserIdColumnToSourceId < ActiveRecord::Migration
  def change
    remove_column :payloads, :user_id
    add_column :payloads, :source_id, :integer
  end
end
