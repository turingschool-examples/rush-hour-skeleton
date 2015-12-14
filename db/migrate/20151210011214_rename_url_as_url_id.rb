class RenameUrlAsUrlId < ActiveRecord::Migration
  def change
    remove_column :requests, :url, :string
  end
end
