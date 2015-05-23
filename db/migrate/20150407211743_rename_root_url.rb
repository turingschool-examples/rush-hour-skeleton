class RenameRootUrl < ActiveRecord::Migration
  def change
    rename_column :clients, :root_url, :rootUrl
  end
end
