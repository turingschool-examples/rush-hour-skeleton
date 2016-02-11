class RenameColumnInClientsTable < ActiveRecord::Migration
  def change
    rename_column :clients, :rootURL, :rootUrl
  end
end
