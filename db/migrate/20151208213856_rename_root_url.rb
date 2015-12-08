class RenameRootUrl < ActiveRecord::Migration
  def change
    rename_column :applications, :root_url, :rootUrl
  end
end
