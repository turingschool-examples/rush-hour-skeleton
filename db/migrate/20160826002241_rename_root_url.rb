class RenameRootUrl < ActiveRecord::Migration
  def change
     rename_column :clients, :rootUrl, :root_url
  end
end
