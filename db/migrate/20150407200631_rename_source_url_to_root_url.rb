class RenameSourceUrlToRootUrl < ActiveRecord::Migration
  def change
    rename_column :clients, :source_url, :root_url
  end
end
