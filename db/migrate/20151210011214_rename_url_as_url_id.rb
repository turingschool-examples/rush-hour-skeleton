class RenameUrlAsUrlId < ActiveRecord::Migration
  def change
    # rename_column :requests, :url, :url_id
    # change_column :requests, :url, :integer
    remove_column :requests, :url, :string
  end
end
