class RenameVisitorToVisitors < ActiveRecord::Migration
  def change
    rename_table :visitor, :visitors
  end
end
