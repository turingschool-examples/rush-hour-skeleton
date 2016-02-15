class RenameColumnInClientsToSnakeCase < ActiveRecord::Migration
  def change
    rename_column :clients, :rootUrl, :root_url
  end
end
